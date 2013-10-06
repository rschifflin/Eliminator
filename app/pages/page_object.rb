class PageObject
  include Capybara::DSL

protected
  def page
    @page ||= Capybara.current_session
  end

end

