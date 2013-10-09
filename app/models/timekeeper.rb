module Timekeeper
  extend self
  def current_week_for season 
    return nil unless season.try(:weeks).try(:present?)
    first_started(season.weeks, :week_no) || first_unstarted(season.weeks, :week_no) || last_finished(season.weeks, :week_no)
  end

  def current_season_from seasons
    return nil unless seasons.try(:present?)
    first_started(seasons, :year) || first_unstarted(seasons, :year) || last_finished(seasons, :year)
  end

private
  
  def first_started(list,comparison)
    list.select { |item| item.started? }.sort_by { |item| item.send(comparison) }.first
  end

  def first_unstarted(list, comparison)
    list.select { |item| item.unstarted? }.sort_by { |item| item.send(comparison) }.first
  end

  def last_finished(list, comparison)
    list.select { |item| item.finished? }.sort_by { |item| item.send(comparison) }.last
  end

end
