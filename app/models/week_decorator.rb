class WeekDecorator < Draper::Decorator
  delegate_all

  def show_games
    if @object.games.present?
      h.content_tag(:li) do 
        GameDecorator.decorate_collection(@object.games).map do |game|
          game.show_teams
        end.join.html_safe
      end.html_safe
    end
  end
end
