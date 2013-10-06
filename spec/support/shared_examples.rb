require "spec_helper.rb"
shared_context "as a signed-in user", signed_in: true do
  let(:sign_in_page) { SignInPage.new } 
  let(:current_user) { create(:user, username: "Frank Bank", email: "frank@bank.com", password: "password") }
  before do
    visit new_user_session_path
    sign_in_page.log_in_with(email: current_user.email, password: "password")
  end
end

