require 'spec_helper'

describe "The Games page" do
  let(:games_page) { GamesPage.new }

  context "During a week with games to be played", signed_in: true do
    let(:season) { create(:season) }
    let(:week) { create(:week, season: season) }
    let(:teams) { create_list(:team, 20) }
    before do
      create_list(:game, 10, home_team: teams.sample, away_team: teams.sample, week: week)
    end

    it "shows me the list of current games this week" do
      visit(games_path)
      expect(games_page.current_games.size).to eq(10)
    end

    it "shows me my current bet" do
      bet = create(:bet, user: current_user, week: week, team: teams.last)
      visit(games_path)
      expect(games_page.current_bet_display).to eq bet.team.full_name
    end

    it "lets me place a bet" do
      visit(games_path)
      expect { games_page.place_bet(game_number: 1, team: :home) }.to change { current_user.bets.count }.by 1
    end

    it "updates my bet display after placing a bet" do
      visit(games_path)
      games_page.place_bet(game_number: 1, team: :home)
      expect { games_page.place_bet(game_number: 1, team: :away) }.to change { games_page.current_bet_display }
    end
    
    it "doesn't record multiple bets in the same week" do
      visit(games_path)
      games_page.place_bet(game_number: 1, team: :home)
      games_page.place_bet(game_number: 1, team: :away)
      expect(current_user.bets.count).to eq 1
    end
  end
end
