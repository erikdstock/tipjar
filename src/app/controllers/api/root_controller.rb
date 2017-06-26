class Api::RootController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { 'api status' => :cool }
  end

  def my_top_artists
    month = params[:date] || 1.month.ago
    payload = current_user_top_artist_data(month)
    p payload
    render json: payload
  end


  def me
    render json: current_user
  end

  def req
    render json: request.env
  end

  private

  def authenticate
    p "************************"
    p current_user
    unless user_signed_in?
      payload = { error: 'You are not signed in' }
      render  status: :unauthorized, json: payload
    end
  end
end
