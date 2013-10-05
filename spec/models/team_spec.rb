require 'spec_helper'

describe Team do
  it { should have_many(:home_games) }
  it { should have_many(:away_games) }

  specify "#full_name" do
    team = create(:team, name: "Vikings", location: "Minnesota")
    expect(team.full_name).to eq("Minnesota Vikings")
  end

  specify "#games returns a list of games where the team is playing" do
    team = create(:team)
    game1 = create(:game, home_team: team)
    game2 = create(:game, home_team: team, away_team: team)
    game3 = create(:game, away_team: team)

    expect(team.games.sort).to eq [game1, game2, game3].sort
  end
end
