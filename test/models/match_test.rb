require "test_helper"
require "minitest/mock"

class MatchTest < ActiveSupport::TestCase
  test "persists alternating local turns" do
    match = Match.create!
    assert_equal "X", match.current_mark
    assert match.play(position: 1)
    assert_equal "O", match.reload.current_mark
    assert match.play(position: 2)
    assert_equal ["X", "O"] + Array.new(7), match.reload.cells
  end

  test "rejects invalid and occupied moves without changing storage" do
    match = Match.create!
    match.play(position: 1)
    [nil, 0, 10, "2", 1].each do |position|
      previous = match.reload.cells
      refute match.play(position: position)
      assert_equal previous, match.reload.cells
    end
  end

  test "wins and draws stop further play" do
    match = Match.create!
    [1, 4, 2, 5, 3].each { |position| assert match.play(position: position) }
    assert_equal "X wins", match.status_label
    refute match.play(position: 6)

    draw = Match.create!
    [1, 2, 3, 5, 4, 6, 8, 7, 9].each { |position| assert draw.play(position: position) }
    assert_equal "Draw", draw.reload.status_label
    assert draw.complete?
  end

  test "validates persisted state and mode" do
    [nil, [], Array.new(9, "Z"), ["O"] + Array.new(8), %w[X X X O O O X O X]].each do |cells|
      refute Match.new(cells: cells).valid?
    end
    refute Match.new(mode: "unknown").valid?
  end

  test "all computer strategies respond in the same stored turn" do
    Match::STRATEGIES.each_key do |strategy|
      match = Match.create!(mode: "computer", strategy: strategy)
      assert match.play(position: 1)
      assert_equal 1, match.reload.cells.count("X")
      assert_equal 1, match.cells.count("O")
      assert_equal 1, match.lock_version
      assert_equal "X", match.current_mark
    end
  end

  test "medium blocks an immediate loss" do
    match = Match.create!(mode: "computer", strategy: "medium", cells: ["X", "X", nil, nil, "O", nil, nil, nil, "O"])
    assert match.play(position: 4)
    assert_equal "O", match.reload.cells[2]
  end

  test "human win does not request a computer reply" do
    match = Match.create!(mode: "computer", strategy: "hard", cells: ["X", "X", nil, "O", "O", nil, nil, nil, nil])
    TicTacToe::ComputerPlayer.stub(:new, ->(**) { flunk "No computer reply should be requested" }) do
      assert match.play(position: 3)
    end
    assert_equal "X wins", match.reload.status_label
  end

  test "failed computer reply does not partially persist the human move" do
    match = Match.create!(mode: "computer", strategy: "easy")
    computer = Minitest::Mock.new
    computer.expect(:choose_move, 1, [TicTacToe::Board])
    TicTacToe::ComputerPlayer.stub(:new, computer) do
      assert_raises(ArgumentError) { match.play(position: 1) }
    end
    computer.verify
    assert_equal Array.new(9), match.reload.cells
    assert_equal 0, match.lock_version
  end

  test "stale and missing revisions do not add a turn" do
    match = Match.create!
    stale = Match.find(match.id)
    assert match.play(position: 1, expected_version: 0)
    refute stale.play(position: 2)
    refute match.play(position: 2, expected_version: nil)
    assert_equal ["X"] + Array.new(8), match.reload.cells
  end

  test "rejects invalid computer configuration and unfinished human-only computer turns" do
    refute Match.new(mode: "computer").valid?
    refute Match.new(mode: "computer", strategy: "unknown").valid?
    refute Match.new(mode: "local", strategy: "hard").valid?
    refute Match.new(mode: "computer", strategy: "hard", cells: ["X"] + Array.new(8)).valid?
  end
end
