require "#{Rails.root}/app/pages/page_object.rb"
class GamesPage < PageObject

  def current_games
    page.all("ul#game-list li.game-entry")
  end

  def current_bet_display
    page.find(".current-bet").text
  end

end
