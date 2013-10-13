class GameDecorator < Draper::Decorator 
  delegate_all 
  def show_teams
    h.content_tag(:div, @object.home_team.full_name + " vs. " + @object.away_team.full_name) 
  end 
end
