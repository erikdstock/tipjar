class DashboardController < ApplicationController
  before_action :authenticate_user!

  def main
    @month = 1.month.ago
    @user = current_user
    @top_artists = @user.top_artists_for_month(@month)
    @top_artists.each do |ta|
      if ta.artist.give_to_incomplete?
        logger.debug "#{ta.artist.name} needs refresh from giveto"
        job = RefreshArtistGiveToInfoJob.perform_later(ta.artist.id)
        logger.debug job
      end
    end
  end
end
