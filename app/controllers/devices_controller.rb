class DevicesController < ApplicationController
  def search
    if params[:q].present?
      @devices = Device.where("brand_name LIKE :keyword OR name LIKE :keyword", keyword:  "%#{params[:q]}%")
    else
      @devices = Device.order(created_at: :desc).limit(10)
    end

    # render layout: false if turbo_frame_request?
  end
end