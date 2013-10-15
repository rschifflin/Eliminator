require 'spec_helper'

describe TeamDecorator do
  describe "#full_name" do
    it "returns the full name" do
      team = Team.new(name: "Vikings", location: "Minnesota")
      expect(team.decorate.full_name).to eq("Minnesota Vikings")
    end
  end
end
