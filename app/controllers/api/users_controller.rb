class API::UsersController < ApplicationController

  def index
    warn "remove this route"
    @users = User.all
    render json: @users
  end
  
end
