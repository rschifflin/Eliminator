require 'spec_helper'

describe StaticController do
  describe "#home" do
    it "correctly renders" do
      get :home
      expect(response.status).to be 200
    end
  end
end
