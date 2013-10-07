require "#{Rails.root}/app/pages/page_object.rb"
class GamesPage < PageObject

  def current_games
    page.all("ul#game-list li.game-entry")
  end

  def current_bet_display
    page.find(".current-bet-team-name").text
  end

  def place_bet(args)
    args = { game_number: 1,
             team: :home }.merge(args)
    
    page.find("li.game-entry[data-id='#{args[:game_number]}'] .bet-home a").click() if args[:team] == :home
    page.find("li.game-entry[data-id='#{args[:game_number]}'] .bet-away a").click() if args[:team] == :away
  end

end
