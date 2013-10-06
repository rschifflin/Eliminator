require "spec_helper"

describe HeaderPage do
  specify "#click_home" do
    header_page = HeaderPage.new
    Capybara.stub(:current_session) { Capybara.string File.read("#{File.dirname(__FILE__)}/html/example1.html") }
    Capybara.current_session.stub(:click) { true }
    expect {header_page.click_home}.to be_true
  end
end
