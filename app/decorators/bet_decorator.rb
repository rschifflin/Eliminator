class BetDecorator < Draper::Decorator
  def show_current
    return nil if @object.nil?
    h.content_tag(:div, class: "current-bet") do
      h.content_tag(:div, "Your pick: " + @object.team.decorate.full_name, class: "current-bet-team-name")
    end
  end
end
