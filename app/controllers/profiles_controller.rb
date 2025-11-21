class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile ||= current_user.create_profile
  end

  def edit
    @profile ||= current_user.create_profile
  end

end