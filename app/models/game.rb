class Game < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team" 
  belongs_to :away_team, class_name: "Team"
  belongs_to :week

  validates :progress, inclusion: { in: %w|upcoming next live final| }
end
