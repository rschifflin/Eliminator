require 'spec_helper'

describe Team do
  specify "#full_name" do
    team = create(:team, name: "Vikings", location: "Minnesota")
    expect(team.full_name).to eq("Minnesota Vikings")
  end
end
