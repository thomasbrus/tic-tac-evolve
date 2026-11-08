require('test_helper')

class MatchesControllerTest < ActionDispatch::IntegrationTest
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
    assert_select('title', text: 'Play | tic-tac-evolve')
    assert_select("meta[name='application-name'][content='Tic-tac-evolve']")
    assert_select("header a.wordmark[href='#{root_path}']", text: 'tic-tac-evolve')
    assert_select('header span.edition', text: 'CLASSIC / 01')
    assert_select('legend', text: 'Opponent')
    assert_select("input[type=submit][value='Start match']")
    assert_select("a[aria-label='Resume match #{match.id}']", text: 'Resume')
    assert_no_match(/translation missing/i, response.body)

    get(match_path(match))
    assert_select('title', text: "Match ##{match.id} | tic-tac-evolve")
    assert_select("[aria-label='Tic-tac-toe board']")
    assert_select("button[aria-label='Square 1, empty']")
    assert_select("h1[role='status']", text: 'X to move')
    assert_select('a', text: 'New match')
    assert_no_match(/translation missing/i, response.body)
  end

  test('active match board keeps accessible move forms and current revision') do
    match = Match.create!(mode: 'local')

    get(match_path(match))

    assert_response(:success)
    board_selector = "[aria-label='Tic-tac-toe board']"
    form_selector = "#{board_selector} form[action='#{move_match_path(match)}']"
    assert_select(form_selector, count: 9)
    (1..9).each do |position|
      assert_select("#{form_selector} input[name='position'][value='#{position}']", count: 1)
      assert_select("#{board_selector} button[aria-label='Square #{position}, empty']", count: 1)
    end
    assert_select("#{form_selector} input[name='revision'][value='#{match.lock_version}']", count: 9)
  end

  test('completed match board keeps labels and has no move controls') do
    match = Match.create!(
      mode: 'local',
      cells: ['X', 'X', 'X', 'O', 'O', nil, nil, nil, nil]
    )

    get(match_path(match))

    assert_response(:success)
    assert_select("h1[role='status']", text: 'X wins')
    board_selector = "[aria-label='Tic-tac-toe board']"
    assert_select("#{board_selector} [aria-label^='Square']", count: 9)
    assert_select("#{board_selector} [aria-label='Square 1, X'].text-red", text: 'X')
    assert_select("#{board_selector} [aria-label='Square 4, O'].text-green", text: 'O')
    assert_select("#{board_selector} [aria-label='Square 6, empty']", count: 1)
    assert_select("#{board_selector} form, #{board_selector} button", count: 0)
  end

  test('setup form renders its default selections') do
    get(root_path)

    assert_select("input[name='match[mode]'][value='computer'][checked]", count: 1)
    assert_select("select[name='match[strategy]'] option[value='hard'][selected]", count: 1)
  end

  test('empty history has no matches or pagination links') do
    get(root_path)

    assert_select('p', text: 'No matches yet.')
    assert_select('ul', count: 0)
    assert_select("nav[aria-label='Match history pages'] a", count: 0)
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
    assert_select("[aria-label='Tic-tac-toe board'] [aria-label='Square 1, X']", text: 'X')
    assert_select('h1', text: 'O to move')
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
    assert_select("form[action='#{matches_path}'] fieldset legend", text: 'Opponent')
    assert_select("form[action='#{matches_path}'] select[name='match[strategy]']", count: 1)
    assert_select('div[role=alert].border-red.text-error', count: 1, text: /Mode/)
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
    assert_select('div[role=alert].border-red.text-error', count: 1, text: /board changed/)
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
    assert_select('li', text: /Active/)
    assert_select('li', text: /Complete/)
    assert_select("a[href='#{match_path(active)}']", text: 'Resume')
    assert_select("a[href='#{match_path(complete)}']", text: 'View match')
  end

  test('history paginates without losing older matches') do
    21.times { Match.create!(mode: 'local') }
    get(root_path)
    assert_select('ul > li', count: 20)
    assert_select("a[href='#{root_path(page: 2)}']", text: 'Next')
    assert_select("nav[aria-label='Match history pages'] a", text: 'Previous', count: 0)
    get(root_path(page: 2))
    assert_select('ul > li', count: 1)
    assert_select("a[href='#{root_path(page: 1)}']", text: 'Previous')
    assert_select("nav[aria-label='Match history pages'] a", text: 'Next', count: 0)
  end
end
