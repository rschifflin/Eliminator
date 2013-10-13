
class GamesController < ApplicationController
  decorates_assigned :week

  def index
    @bet = current_user.current_bet if current_user.try(:current_bet) 
    @week = Week.where(id: params[:week_id]).first
  end
end
