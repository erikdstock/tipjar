class DashboardController < ApplicationController
  before_action :authenticate_user!

  def main
    @month = 1.month.ago
    @user = current_user
    @top_artists = @user.top_artists_for_month(@month)
  end
end
