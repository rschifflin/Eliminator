class TeamDecorator < Draper::Decorator
  def full_name
    "#{@object.location} #{@object.name}"
  end
end
