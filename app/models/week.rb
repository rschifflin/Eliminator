# == Schema Information
#
# Table name: weeks
#
#  id         :integer          not null, primary key
#  week_no    :integer
#  season_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Week < ActiveRecord::Base
  belongs_to :season
  has_many :games

  validates :season, presence: true
  before_save :set_week_no

  def self.current
    return nil unless current_season = Season.current
    current_season.weeks.max_by{ |w| w.week_no }
  end

private

  def set_week_no
    self.week_no = season.assign_next_week_no if self.week_no.nil?
    true
  end

end
