require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.feature "Dashboard - Monthly Top Artists", type: :feature do
  before :all do
    # Stub time + Omniauth
    travel_to Time.new(2016, 6, 15).utc
    stub_omniauth
    # Log in
    visit root_path
    VCR.use_cassette 'lastfm_user_getrecenttracks_dash' do
      click_link "Sign in with last.fm"
    end
  end
  # after(:all) { travel_back } # Should be stubbing when needed time ayways

  scenario "User sees the previous month's top artists on their dashboard" do
    expect(page).to have_content "Top Artists for May 2016"
  end
end
