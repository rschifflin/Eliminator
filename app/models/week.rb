# == Schema Information
#
# Table name: weeks
#
#  id         :integer          not null, primary key
#  week_no    :integer
#  season     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Week < ActiveRecord::Base
  validates :season, presence: true
  belongs_to :season

  before_save :set_week_no

private

  def set_week_no
    self.week_no = season.assign_next_week_no if self.week_no.nil?
    puts "Called by #{self}, who was assigned #{self.week_no}. Season has #{self.season.weeks.count} weeks"
    return true
  end

end
