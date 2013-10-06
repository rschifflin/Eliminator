require 'spec_helper'

Capybara.default_driver = :selenium
Capybara.default_wait_time = 10000
describe "The Games page" do
  let(:games_page) { GamesPage.new }

  context "During a week with games to be played", signed_in: true do
    let(:season) { create(:season) }
    let(:week) { create(:week, season: season) }
    let(:teams) { create_list(:team, 20) }
    before do
      create_list(:game, 10, home_team: teams.sample, away_team: teams.sample, week: week)
    end

    it "should show me the list of current games this week" do
      visit(root_path)
      expect(games_page.current_games.size).to eq(10)
    end

    it "should show me my current bet" do
      bet = create(:bet, user: current_user, week: week, team: teams.last)
      visit(root_path)
      save_screenshot("ss.png")
      expect(games_page.current_bet_display).to eq bet.team.full_name
    end

  end
end
