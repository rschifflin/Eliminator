require 'spec_helper'

describe BetsController do
  include Devise::TestHelpers

  describe "#create" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:season) { create(:season) }
    let!(:week) { create(:week, season: season) }

    context "without a signed-in user" do
      it "doesn't create a bet" do
        expect { post :create, bet: {team_id: team.id, week_id: week.id, user_id: user.id} }.to_not change { user.bets.count }
      end
    end

    context "with a signed-in user" do
      before { sign_in user } 
      it "creates a bet if the user provided is the current user" do
        expect { post :create, bet: {team_id: team.id, week_id: week.id, user_id: user.id} }.to change { user.bets.count }
      end
      
      it "doesn't create a bet if the user provided isn't the current user" do
        other_user = create(:user)
        expect { post :create, bet: {team_id: team.id, week_id: week.id, user_id: other_user.id} }.to_not change { other_user.bets.count }
      end
    end
  end
end
