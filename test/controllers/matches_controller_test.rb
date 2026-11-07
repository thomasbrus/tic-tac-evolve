require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "starts a local match and restores it on refresh" do
    get root_path
    assert_response :success
    assert_difference "Match.count", 1 do
      post matches_path, params: { match: { mode: "local" } }
    end
    match = Match.order(:id).last
    assert_redirected_to match_path(match)
    post move_match_path(match), params: { position: "1", revision: "0" }
    assert_redirected_to match_path(match)
    get match_path(match)
    assert_select ".mark-x", text: "X"
    assert_select "h1", text: "O to move"
  end

  test "rejects malformed positions and completed game moves" do
    match = Match.create!(mode: "local")
    ["0", "10", "1junk", nil, { bad: "1" }].each do |position|
      post move_match_path(match), params: { position: position, revision: "0" }
      assert_response :unprocessable_content
      assert_equal Array.new(9), match.reload.cells
    end
    [1, 4, 2, 5, 3].each { |position| match.play(position: position) }
    previous = match.cells
    post move_match_path(match), params: { position: "6", revision: match.lock_version }
    assert_response :unprocessable_content
    assert_equal previous, match.reload.cells
  end

  test "does not create a match with invalid settings" do
    assert_no_difference "Match.count" do
      post matches_path, params: { match: { mode: "unknown" } }
    end
    assert_response :unprocessable_content
  end

  test "creates computer matches for all four strategies" do
    Match::STRATEGIES.each_key do |strategy|
      post matches_path, params: { match: { mode: "computer", strategy: strategy } }
      match = Match.order(:id).last
      assert_equal strategy, match.strategy
      post move_match_path(match), params: { position: "1", revision: "0" }
      assert_redirected_to match_path(match)
      assert_equal 1, match.reload.cells.count("O")
    end
  end

  test "rejects duplicate and missing revisions without extra turns" do
    match = Match.create!(mode: "local")
    post move_match_path(match), params: { position: "1", revision: "0" }
    assert_response :see_other
    post move_match_path(match), params: { position: "2", revision: "0" }
    assert_response :unprocessable_content
    assert_select "[role=alert]", text: /board changed/
    post move_match_path(match), params: { position: "2" }
    assert_response :unprocessable_content
    assert_equal ["X"] + Array.new(8), match.reload.cells
  end

  test "does not accept unknown computer strategies or client board state" do
    assert_no_difference "Match.count" do
      post matches_path, params: { match: { mode: "computer", strategy: "unknown" } }
    end
    assert_response :unprocessable_content
    post matches_path, params: { match: { mode: "local", cells: Array.new(9, "X"), lock_version: 99 } }
    match = Match.order(:id).last
    assert_equal Array.new(9), match.cells
    assert_equal 0, match.lock_version
  end

  test "history shows active and completed matches with working resume links" do
    active = Match.create!(mode: "local")
    complete = Match.create!(mode: "local", cells: ["X", "X", "X", "O", "O", nil, nil, nil, nil])
    get root_path
    assert_select ".state-label.active", text: "Active"
    assert_select ".state-label.finished", text: "Complete"
    assert_select "a[href='#{match_path(active)}']", text: "Resume"
    assert_select "a[href='#{match_path(complete)}']", text: "View match"
  end

  test "history paginates without losing older matches" do
    21.times { Match.create!(mode: "local") }
    get root_path
    assert_select ".history-list li", count: 20
    assert_select "a[href='#{root_path(page: 2)}']", text: "Next"
    get root_path(page: 2)
    assert_select ".history-list li", count: 1
    assert_select "a[href='#{root_path(page: 1)}']", text: "Previous"
  end
end
