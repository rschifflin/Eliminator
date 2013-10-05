# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base

  has_many :home_games, class_name: "Game", foreign_key: :home_team_id
  has_many :away_games, class_name: "Game", foreign_key: :away_team_id

  def full_name
    "#{location} #{name}" 
  end

  def games
    (self.home_games + self.away_games).uniq
  end

end
