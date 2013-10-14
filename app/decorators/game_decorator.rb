class GameDecorator < Draper::Decorator 
  def show_teams
    h.content_tag(:h3, @object.home_team.decorate.full_name + " vs. " + @object.away_team.decorate.full_name, class: "subheader") 
  end 

  def show_bets
    h.content_tag(:div, class: "bet-home") do
      h.link_to("Bet #{@object.home_team.decorate.full_name}", { controller: "bets", action: "create", bet: {team_id: @object.home_team_id, week_id: @object.week_id } }, method: :post, class: "button radius") 
    end + 
    h.content_tag(:div, class: "bet-away") do
      h.link_to("Bet #{@object.away_team.decorate.full_name}", { controller: "bets", action: "create", bet: {team_id: @object.away_team_id, week_id: @object.week_id } }, method: :post, class: "button radius") 
    end
  end

  def show_game
    show_teams + show_bets
  end
end
