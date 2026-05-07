class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @desk_setup = DeskSetup.find(params[:desk_setup_id])
    @desk_setup.likes.create(user: current_user)
    @desk_setup.reload
    render :update_like
  end

  def destroy
    @desk_setup = DeskSetup.find(params[:desk_setup_id])
    @desk_setup.likes.find_by(user: current_user)&.destroy
    @desk_setup.reload
    render :update_like
  end
end