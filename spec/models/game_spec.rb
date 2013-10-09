require 'spec_helper'

describe Game do
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }
  it { should ensure_inclusion_of(:progress).in_array(%w|unstarted started|) }
  it { should ensure_inclusion_of(:home_team_outcome).in_array(%w|none win lose tie|) }

  it "has a factory" do
    expect(create(:game)).to be_valid
  end

  it "has a default progress of 'unstarted'" do
    expect(Game.create.progress).to eq("unstarted")
  end

  it "has a default home_team_outcome of 'none'" do
    expect(Game.create.home_team_outcome).to eq("none")
  end

  it "notifies its week to start when it starts" do
    game = Game.new
    week = double(Week)
    game.stub(:week) { week }
    week.should_receive(:start_game)
    game.start
  end

end
