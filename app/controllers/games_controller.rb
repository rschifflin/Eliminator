class GamesController < ApplicationController
  decorates_assigned :bet
  decorates_assigned :week

  def index
    @bet = current_user.try(:current_bet) 
    @week = Week.where(id: params[:week_id]).first
  end
end
