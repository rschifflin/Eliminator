class GamesController < ApplicationController
  def index
    @bet = current_user.current_bet if current_user.try(:current_bet) 
  end
end
