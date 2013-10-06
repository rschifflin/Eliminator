class BetsController < ApplicationController
  before_filter :authenticate_user!

  def create
    bet = Bet.create(bet_params)
    flash[:notice] = bet.errors.full_messages if bet.invalid?

    redirect_to week_games_path(params[:bet][:week_id])
  end 

private
  def bet_params
    params[:bet][:user_id] = current_user.id
    params.require(:bet).permit(:user_id, :team_id, :week_id)
  end
end
