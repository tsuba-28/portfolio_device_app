class DeskSetupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_guest_user, only: [:update, :destroy]

  def index
# N＋1問題を避けるために user, style, tagsテーブルを事前に取得（Eager Loading）
    @desk_setups = DeskSetup.includes(:user, :style, :tags)
                            .order(created_at: :desc)

    if params[:style_id].present?
      @desk_setups = @desk_setups.where(style_id: params[:style_id])
    end
  end

  def show
    @desk_setup = DeskSetup.includes(:style, :devices, :base_tags, user: :profile)
                            .find(params[:id])
  end

  def new
    @desk_setup = DeskSetup.new
  end

  def create
    @desk_setup = current_user.desk_setups.build(desk_setup_params)
    if @desk_setup.save
      redirect_to desk_setup_path(@desk_setup), notice: "投稿できました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @desk_setup = DeskSetup.find(params[:id])
  end

  def update
    @desk_setup = DeskSetup.find(params[:id])
#既存画像の削除処理
    if params[:desk_setup][:delete_image_ids].present?
      image_ids = params[:desk_setup][:delete_image_ids].reject(&:blank?)#空文字""を除外してエラー対策
      image_ids.each do |image_id|
        #紐づいている画像の中から該当IDを探して削除
        @desk_setup.images.find(image_id).purge
      end
    end
#デバイスの削除処理(紐付け解除)
    if params[:desk_setup][:delete_device_ids].present?
      device_ids = params[:desk_setup][:delete_device_ids].reject(&:blank?)#空文字""を除外
      devices_to_delete = @desk_setup.devices.where(id: device_ids)
      @desk_setup.devices.delete(devices_to_delete)
    end

    if @desk_setup.update(desk_setup_params.except(:images))
      redirect_to desk_setup_path(@desk_setup), notice: "更新できました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    desk_setup = DeskSetup.find(params[:id])
    desk_setup.destroy!
    redirect_to root_path, status: :see_other, notice: "削除することに成功しました！"
  end

  def add_device
    @device = Device.find(params[:device_id])
    render turbo_stream: turbo_stream.append("selected_devices", partial: "selected_device", locals: { device: @device })
  end

  private
  def check_guest_user
    if current_user.email == 'guestguest33@sample.com'
    redirect_to desk_setup_path, alert: "ゲストユーザーは閲覧のみ可能です。保存 / 削除は行えません。"
    end
  end

  def desk_setup_params
    params.required(:desk_setup).permit(
      :style_id,
      :title,
      :content,
      images: [],
      device_ids: [],
      tag_list: []
    )
  end
end