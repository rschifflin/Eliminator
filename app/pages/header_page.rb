require "#{Rails.root}/app/pages/page_object.rb"
class HeaderPage < PageObject

  def click_home
    click_on("Eliminator")
  end

  def click_games
    click_on("Games This Week")
  end

end
