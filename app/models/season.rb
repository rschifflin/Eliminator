# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  year       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Season < ActiveRecord::Base
  has_many :weeks
  has_many :games, through: :weeks

  def assign_next_week_no
    @latest_week_no ||= (self.weeks.map { |w| w.week_no }.max || 0)
    @latest_week_no += 1
  end

  def self.current 
    return nil if Season.first.nil?
    return Season.all.max_by{ |s| s.year }
  end
end
