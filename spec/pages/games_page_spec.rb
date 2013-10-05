require 'spec_helper'

describe GamesPage do
  describe "#current_games" do
    let(:season) { create(:season) }
    let(:week) { create(:week, season: season) }
    let(:games) { create_list(:game, 3, week: week) }

    it "returns an array of this week's games" do
      Capybara.stub(:current_session) do
        Capybara.string( <<-eos)
          <html>
            <head>
            </head>
            <body>
              <ul id="game-list">
                <li class="game-entry">Game 1</li>
                <li class="game-entry">Game 2</li>
                <li class="game-entry">Game 3</li>
              </ul>
            </body>
          </html> 
        eos
      end
      games_page = GamesPage.new

      expect(games_page.current_games.size).to eq 3
    end
  end
end
