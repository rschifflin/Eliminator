# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  year       :integer
#  progress   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Season < ActiveRecord::Base
  state_machine :progress, initial: :unstarted do
    before_transition :started => :finished do |season|
    end

    event :start_week do
      transition [:unstarted, :started] => :started
    end
    
    event :finish_week do
      transition :started => :finished , if: lambda { |season| season.reload.weeks.all? { |week| week.finished? } }
    end
  end

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
