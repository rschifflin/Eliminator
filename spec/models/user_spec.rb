require 'spec_helper'

describe User do
  specify "User has username" do
    user = create(:user, username: "FrankBank") 
    expect(user.username).to eq("FrankBank")
  end

  specify "User has email" do
    user = create(:user, email: "Frank@Bank.com") 
    expect(user.email).to eq("Frank@Bank.com")
  end
end

