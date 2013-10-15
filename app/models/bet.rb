# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  week_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UniqueBetValidator < ActiveModel::Validator
  def validate(bet)
    @bet = bet
    validate_prior_bet
    validate_week_progress
    validate_current_week
  end

private
  def validate_prior_bet
    original_bet = Bet.joins(:week).where("team_id = ? AND user_id = ? AND season_id = ?", @bet.team, @bet.user, @bet.week.season).first
    unless original_bet.nil? || original_bet.id == @bet.id
      @bet.errors[:base] << "You already bet on the #{@bet.team.decorate.full_name} this season!"
    end
  end

  def validate_week_progress
    unless @bet.week.progress == :unstarted
      @bet.errors[:base] << "This week's games have already started!"
    end
  end

  def validate_current_week
    unless @bet.week_id == Week.current.id
      @bet.errors[:base] << "You may only bet on the current week's games!"
    end
  end
end

class Bet < ActiveRecord::Base
  belongs_to :team
  belongs_to :week
  belongs_to :user
  validates_with UniqueBetValidator
  before_save :replace_old_bet 

private
  def replace_old_bet
    Bet.where("user_id = ? AND week_id = ?", user, week).first.try(:destroy)
  end
  
end
