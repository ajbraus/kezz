class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @libraries = @user.libraries
    @attempted_readings = []
    @completed_readings = []
  end
end