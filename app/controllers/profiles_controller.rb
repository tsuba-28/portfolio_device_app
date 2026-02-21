class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    if params[:profile][:remove_avatar] == "1"
      @profile.avatar.purge
    end

    if params[:profile][:remove_background] == "1"
      @profile.background.purge
    end

    if @profile.update(profile_params)
      redirect_to @profile, notice: '更新できました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_profile
      @profile = current_user.profile || current_user.create_profile
    end

    def profile_params
      params.require(:profile).permit(
        :nickname,
        :usertag,
        :bio,
        :avatar,
        :background,
        :remove_avatar,
        :remove_background
      )
    end

end