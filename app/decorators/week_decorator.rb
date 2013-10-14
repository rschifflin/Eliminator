class WeekDecorator < Draper::Decorator
  def show_games
    if @object.games.present?
      GameDecorator.decorate_collection(@object.games).each_with_index.map do |game, index|
        h.content_tag(:li, class: "game-entry", data: { id: index+1 }) do
          game.show_game
        end
      end.join.html_safe
    end.html_safe
  end
end

