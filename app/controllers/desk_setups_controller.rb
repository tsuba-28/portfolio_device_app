class DeskSetupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @desk_setup = DeskSetup.all
  end

  def show
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

  private
  def desk_setup_params
    params.required(:desk_setup).permit(:style_id, :title, :content, images: [], device_ids: [], tag_list: [] )
  end
end