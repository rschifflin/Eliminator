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
  belongs_to :home_team, class_name: "Team" 
  belongs_to :away_team, class_name: "Team"
  belongs_to :week

  validates :progress, inclusion: { in: %w|upcoming next live final| }

  before_validation :set_default_progress

private
  def set_default_progress
    self.progress ||= "upcoming"
    true
  end
end
