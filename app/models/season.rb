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
    before_transition [:unstarted, :started] => :finished do |season|
    end

    event :start do
      transition [:unstarted, :started] => :started
    end
    
    event :finish do
      transition [:unstarted, :started] => :finished 
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

  def on_week_start
    self.start
  end

  def on_week_finish
    self.finish if self.reload.weeks.all? { |week| week.finished? } 
  end
end
