require('test_helper')

class MatchesControllerTest < ControllerTest
  test('partials reject missing and unexpected locals') do
    get(root_path)
    view = controller.view_context

    missing = assert_raises(ActionView::Template::Error) do
      view.render(partial: 'matches/history_heading')
    end
    assert_kind_of(ActionView::StrictLocalsError, missing.cause)

    unexpected = assert_raises(ActionView::Template::Error) do
      view.render(partial: 'matches/setup_heading', locals: { unexpected: true })
    end
    assert_kind_of(ActionView::StrictLocalsError, unexpected.cause)
  end

  test('view scoped translations render page text and accessible labels') do
    match = Match.create!(mode: 'local')
    get(root_path)
    assert_selector('title', visible: :all, text: 'Play | tic-tac-evolve')
    assert_selector("meta[name='application-name'][content='Tic-tac-evolve']", visible: :all)
    assert_selector(:link, 'tic-tac-evolve', href: root_path)
    assert_selector("[data-test-id='edition']", text: 'CLASSIC / 01')
    assert_selector(:fieldset, 'Opponent')
    assert_selector(:button, 'Start match')
    assert_selector(:link, "Resume match #{match.id}", text: 'Resume')
    assert_no_match(/translation missing/i, response.body)

    get(match_path(match))
    assert_selector('title', visible: :all, text: "Match ##{match.id} | tic-tac-evolve")
    assert_selector("[aria-label='Tic-tac-toe board']")
    assert_selector(:button, 'Square 1, empty')
    assert_selector(:heading, 'X to move', level: 1)
    assert_selector("[role='status']", text: 'X to move')
    assert_selector(:link, 'New match')
    assert_no_match(/translation missing/i, response.body)
  end

  test('active match board keeps accessible move forms and current revision') do
    match = Match.create!(mode: 'local')

    get(match_path(match))

    assert_response(:success)
    board_selector = "[aria-label='Tic-tac-toe board']"
    form_selector = "#{board_selector} form[action='#{move_match_path(match)}']"
    assert_selector(form_selector, count: 9)
    (1..9).each do |position|
      assert_selector("#{form_selector} input[name='position'][value='#{position}']", visible: :all, count: 1)
      assert_selector(:button, "Square #{position}, empty", count: 1)
    end
    assert_selector("#{form_selector} input[name='revision'][value='#{match.lock_version}']", visible: :all, count: 9)
  end

  test('completed match board keeps labels and has no move controls') do
    match = Match.create!(
      mode: 'local',
      cells: ['X', 'X', 'X', 'O', 'O', nil, nil, nil, nil]
    )

    get(match_path(match))

    assert_response(:success)
    assert_selector(:heading, 'X wins', level: 1)
    assert_selector("[role='status']", text: 'X wins')
    board_selector = "[aria-label='Tic-tac-toe board']"
    assert_selector("#{board_selector} [aria-label^='Square']", count: 9)
    match.cells.each_with_index do |mark, index|
      assert_selector("#{board_selector} [aria-label='Square #{index + 1}, #{mark || 'empty'}']", count: 1, text: mark)
    end
    assert_no_selector("#{board_selector} form, #{board_selector} button")
  end

  test('setup form renders its default selections') do
    get(root_path)

    assert_selector(:radio_button, 'Computer', checked: true, count: 1)
    assert_selector(:select, 'Difficulty', selected: 'Hard', count: 1)
  end

  test('empty history has no matches or pagination links') do
    get(root_path)

    assert_text('No matches yet.')
    assert_no_selector('ul')
    assert_selector(:navigation, 'Match history pages')
    assert_no_selector("nav[aria-label='Match history pages'] a")
  end

  test('starts a local match and restores it on refresh') do
    get(root_path)
    assert_response(:success)
    assert_difference('Match.count', 1) do
      post(matches_path, params: { match: { mode: 'local' } })
    end
    match = Match.order(:id).last
    assert_redirected_to(match_path(match))
    post(move_match_path(match), params: { position: '1', revision: '0' })
    assert_redirected_to(match_path(match))
    get(match_path(match))
    assert_selector("[aria-label='Tic-tac-toe board'] [aria-label='Square 1, X']", text: 'X')
    assert_selector(:heading, 'O to move', level: 1)
  end

  test('rejects malformed positions and completed game moves') do
    match = Match.create!(mode: 'local')
    ['0', '10', '1junk', nil, { bad: '1' }].each do |position|
      post(move_match_path(match), params: { position: position, revision: '0' })
      assert_response(:unprocessable_content)
      assert_equal(Array.new(9), match.reload.cells)
    end
    [1, 4, 2, 5, 3].each { |position| match.play(position: position) }
    previous = match.cells
    post(move_match_path(match), params: { position: '6', revision: match.lock_version })
    assert_response(:unprocessable_content)
    assert_equal(previous, match.reload.cells)
  end

  test('does not create a match with invalid settings') do
    assert_no_difference('Match.count') do
      post(matches_path, params: { match: { mode: 'unknown' } })
    end
    assert_response(:unprocessable_content)
    form = page.find("form[action='#{matches_path}']")
    assert_selector(form, :fieldset, 'Opponent')
    assert_selector(form, :select, 'Difficulty', name: 'match[strategy]', count: 1)
    assert_selector(:alert, count: 1, text: /Mode/)
  end

  test('creates computer matches for all four strategies') do
    Match::STRATEGIES.each_key do |strategy|
      post(matches_path, params: { match: { mode: 'computer', strategy: strategy } })
      match = Match.order(:id).last
      assert_equal(strategy, match.strategy)
      post(move_match_path(match), params: { position: '1', revision: '0' })
      assert_redirected_to(match_path(match))
      assert_equal(1, match.reload.cells.count('O'))
    end
  end

  test('rejects duplicate and missing revisions without extra turns') do
    match = Match.create!(mode: 'local')
    post(move_match_path(match), params: { position: '1', revision: '0' })
    assert_response(:see_other)
    post(move_match_path(match), params: { position: '2', revision: '0' })
    assert_response(:unprocessable_content)
    assert_selector(:alert, count: 1, text: /board changed/)
    post(move_match_path(match), params: { position: '2' })
    assert_response(:unprocessable_content)
    assert_equal(['X'] + Array.new(8), match.reload.cells)
  end

  test('does not accept unknown computer strategies or client board state') do
    assert_no_difference('Match.count') do
      post(matches_path, params: { match: { mode: 'computer', strategy: 'unknown' } })
    end
    assert_response(:unprocessable_content)
    post(matches_path, params: { match: { mode: 'local', cells: Array.new(9, 'X'), lock_version: 99 } })
    match = Match.order(:id).last
    assert_equal(Array.new(9), match.cells)
    assert_equal(0, match.lock_version)
  end

  test('history shows active and completed matches with working resume links') do
    active = Match.create!(mode: 'local')
    complete = Match.create!(mode: 'local', cells: ['X', 'X', 'X', 'O', 'O', nil, nil, nil, nil])
    get(root_path)
    assert_selector("[data-test-id='history-match']", text: /Active/)
    assert_selector("[data-test-id='history-match']", text: /Complete/)
    assert_selector(:link, "Resume match #{active.id}", href: match_path(active), text: 'Resume')
    assert_selector(:link, "View match #{complete.id}", href: match_path(complete), text: 'View match')
  end

  test('history paginates without losing older matches') do
    21.times { Match.create!(mode: 'local') }
    get(root_path)
    assert_selector("[data-test-id='history-match']", count: 20)
    assert_selector(:link, 'Next', href: root_path(page: 2))
    assert_no_selector(page.find(:navigation, 'Match history pages'), :link, 'Previous')
    get(root_path(page: 2))
    assert_selector("[data-test-id='history-match']", count: 1)
    assert_selector(:link, 'Previous', href: root_path(page: 1))
    assert_no_selector(page.find(:navigation, 'Match history pages'), :link, 'Next')
  end
end
