require 'spec_helper'

describe Game do
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }
  it { should ensure_inclusion_of(:progress).in_array(%w|upcoming next live final|) }
  it { should ensure_inclusion_of(:home_team_outcome).in_array(%w|none win lose tie|) }

  it "has a factory" do
    expect(create(:game)).to be_valid
  end

  it "has a default progress of 'upcoming'" do
    expect(Game.create.progress).to eq("upcoming")
  end

  it "has a default home_team_outcome of 'none'" do
    expect(Game.create.home_team_outcome).to eq("none")
  end

end
