class API::UsersController < ApplicationController

  def index
    warn "remove this route"
    @users = User.all
    render json: @users
  end

  def top_artists
    block_evil! unless current_user
    raw_data = current_user.get_top_artists
    render json: raw_data
  end

  def recent_tracks
    block_evil! unless current_user
    raw_data = current_user.get_recent_tracks
    render json: raw_data
  end

  private

  def block_evil!
    render json: {message: 'no fools'}
    return false
  end

end
