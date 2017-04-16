class Api::RootController < ApplicationController
  before_action :authenticate

  def index
    render json: { 'api status' => :cool }
  end

  def me
    render json: current_user
  end

  def req
    render json: request.env
  end

  private

  def authenticate
    unless user_signed_in?
      payload = { error: 'You are not signed in' }
      render  status: :unauthorized, json: payload
    end
  end
end
