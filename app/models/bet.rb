class UniqueBetValidator < ActiveModel::Validator
  def validate(bet)
    original_bet = Bet.joins(:week).where("team_id = ? AND user_id = ? AND season_id = ?", bet.team, bet.user, bet.week.season).first
    unless original_bet.nil? || original_bet.id == bet.id
      bet.errors[:unique] << "Tried to place bet #{bet.inspect}, but already placed bet #{original_bet.inspect} on the #{bet.team.full_name} this season"
    end
  end
end

class Bet < ActiveRecord::Base
  belongs_to :team
  belongs_to :week
  belongs_to :user
  validates_with UniqueBetValidator
end
