class Api::RootController < ApplicationController
  include Concerns::AuthHelpers
  before_action :authenticate

  def index
    render json: { 'api status' => :cool }
  end

  def my_top_artists
    p "************************** Docker host ip is wrong?"
    p ENV['DOCKER_HOST_IP']
    month = params[:date] || 1.month.ago
    payload = user_top_artist_data(month)
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
    unless current_user
      payload = { error: 'You are not signed in' }
      render  status: :unauthorized, json: payload
    end
  end
end
