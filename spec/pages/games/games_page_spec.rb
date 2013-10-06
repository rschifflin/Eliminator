require 'spec_helper'

describe GamesPage do
  describe "#current_games" do
    let(:season) { create(:season) }
    let(:week) { create(:week, season: season) }
    let(:games) { create_list(:game, 3, week: week) }

    it "returns an array of this week's games" do
      Capybara.stub(:current_session) do
        Capybara.string( File.read("#{File.dirname(__FILE__)}/html/example1.html") )
      end
      games_page = GamesPage.new

      expect(games_page.current_games.size).to eq 3
    end

    it "displays the current user's bet this week" do
      Capybara.stub(:current_session) do
        Capybara.string( File.read("#{File.dirname(__FILE__)}/html/example1.html") )
      end
      expect(GamesPage.new.current_bet_display).to eq("Minnesota Vikings")
    end
  end

  describe "#place_bet" do
    let(:season) { create(:season) }
    let(:week) { create(:week, season: season) }
    let(:games) { create_list(:game, 10, week: week) }

    it "clicks on the bet button for a team" do

    end
  end
end
