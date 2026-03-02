class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])

    @profile = @user.profile

    @desk_setups = @user.desk_setups
                        .with_attached_images
                        .includes(:style, :tags)
                        .order(created_at: :desc)
                        .limit(10)

    @devices = Device.joins(:desk_setups)
                      .where(desk_setups: { user_id: @user.id })
                      .distinct
  end
end