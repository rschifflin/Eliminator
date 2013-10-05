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

  def assign_next_week_no
    @latest_week_no ||= 0
    @latest_week_no += 1
  end
end
