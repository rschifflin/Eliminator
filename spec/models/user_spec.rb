require 'spec_helper'

describe User do
  specify "User has username" do
    user = create(:user, username: "FrankBank", email: "Frank@Bank.com", password: "password", password_confirmation: "password") 
    expect(user.username).to eq("FrankBank")
  end

  specify "User has email" do
    user = create(:user, username: "FrankBank", email: "Frank@Bank.com", password: "password", password_confirmation: "password") 
    expect(user.email).to eq("frank@bank.com")
  end
end

