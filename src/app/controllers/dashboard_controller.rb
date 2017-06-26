class DashboardController < ApplicationController
  # before_action :authenticate_user!

  # Load initial data for the dashboard [rendered in react]
  def main
    if current_user
      p "$$$$$$$$$$$$$$$$$$$$", current_user
      month = 1.month.ago
      artists = current_user_top_artist_data(month)
      initial_data = { session: {jwt: current_user.jwt}, user: current_user.as_json, artistData: { artists: top_artists } }
    else
      initial_data = {}
    end
    load_initial_data(initial_data)
  end
end
