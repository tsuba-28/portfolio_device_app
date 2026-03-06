class DeskSetupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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
      Rails.logger.debug "保存エラーの内容: #{@desk_setup.errors.full_messages}"
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
      params[:desk_setup][:delete_image_ids].each do |image_id|
        #紐づいている画像の中から該当IDを探して削除
        image = @desk_setup.images.find(image_id)
        image.purge
      end
    end
#デバイスの削除処理(紐付け解除)
    if params[:desk_setup][:delete_device_ids].present?
      @desk_setup.devices.delete(params[:desk_setup][:delete_device_ids])
    end

    if params[:desk_setup][:images].present?
      @desk_setup.images.attach(params[:desk_setup][:images])
    end

    if @desk_setup.update(desk_setup_params)
      redirect_to desk_setup_path(@desk_setup), notice: "更新できました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def add_device
    @device = Device.find(params[:device_id])
    render turbo_stream: turbo_stream.append("selected_devices", partial: "selected_device", locals: { device: @device })
  end

  private
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