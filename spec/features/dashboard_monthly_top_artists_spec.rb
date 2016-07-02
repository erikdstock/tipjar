require 'rails_helper'

RSpec.feature "Dashboard - Monthly Top Artists", type: :feature do
  before do
    set_omniauth
    click_link 'Sign in with last.fm'
    DateTime.stub(:now) {DateTime.new(2016, 5, 15)}
  end

  scenario "User sees the previous month's top artists on login" do
    page.should_have_content "Monthly Top Artists"
    
  end
end
