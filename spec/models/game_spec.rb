require 'spec_helper'

describe Game do
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }
  it { should ensure_inclusion_of(:progress).in_array(%w|upcoming next live final|) }

  it "has a factory" do
    expect(create(:game)).to be_valid
  end

  it "has a default progress of 'upcoming'" do
    expect(Game.create.progress).to eq("upcoming")
  end

end
