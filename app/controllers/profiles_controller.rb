class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
    @profile = current_user.profile
    @user = @profile.user

#ユーザーが投稿したデスクセットアップを「まとめて」取得
    @desk_setups = @user.desk_setups
                        .with_attached_images     #画像のN＋1問題への対策
                        .includes(:style, :tags)  #関連データのN＋1問題への対策
                        .order(created_at: :desc) #新規投稿順に並べる
                        .limit(10)                #表示数を制限

#ユーザーの全投稿デスクに関連付けされたデバイスをカテゴリー情報と一緒に取得
    @devices = Device.joins(:desk_setups)
                      .where(desk_setups: { user_id: current_user.id })
                      .includes(:category) #N＋1問題への対策
                      .distinct            #重複を排除
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
      @profile = current_user.profile
    end

    def profile_params
      params.require(:profile).permit(
        :nickname,
        :bio,
        :avatar,
        :background,
        :remove_avatar,
        :remove_background
      )
    end

end