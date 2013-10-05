class GamesPage
  include Capybara::DSL

  def current_games
    page.all("ul#game-list li.game-entry")
  end

private
  def page
    @page ||= Capybara.current_session
  end

end
