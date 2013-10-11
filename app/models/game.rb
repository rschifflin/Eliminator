# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  home_team_id      :integer
#  away_team_id      :integer
#  week_id           :integer
#  home_team_outcome :string(255)
#  progress          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Game < ActiveRecord::Base
  state_machine :progress, initial: :unstarted do
    after_transition :unstarted => :started, do: :notify_week_start
    after_transition [:unstarted, :started] => :finished, do: :notify_week_end
    event :start do
      transition :unstarted => :started
    end

    event :finish do
      transition [:unstarted, :started] => :finished
    end
  end

  belongs_to :home_team, class_name: "Team" 
  belongs_to :away_team, class_name: "Team"
  belongs_to :week

  validates :progress, inclusion: { in: %w|unstarted started finished| }
  validates :home_team_outcome, inclusion: { in: %w|none win lose tie| }

  before_validation :set_defaults

private
  def set_defaults
    self.home_team_outcome ||= "none"
    true
  end

  def notify_week_start
    self.week.start_game
  end

  def notify_week_end
    self.week.end_game
  end
end
