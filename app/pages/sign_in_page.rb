require "#{Rails.root}/app/pages/page_object.rb"

class SignInPage < PageObject
  def log_in_with(args_hash)
    args_hash = { email: "",
      password: "" }.merge args_hash
    fill_in("user_email", with: args_hash[:email])
    fill_in("user_password", with: args_hash[:password])
    click_on("Sign in")
  end
end
