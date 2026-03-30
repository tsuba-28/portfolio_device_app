class DevicesController < ApplicationController
  def search
    if params[:q].present?
      partial_keyword = "%#{params[:q]}%"  #部分一致
      exact_keyword   = params[:q]         #完全一致

      devices_table = Device.arel_table
      categories_table = Category.arel_table

      #カラムごとに一致条件を変更
      @devices = Device.joins(:category).includes(:category).where(
        devices_table[:brand_name].matches(partial_keyword)
        .or(devices_table[:name].matches(partial_keyword))
        .or(categories_table[:name].matches(exact_keyword))
        .or(categories_table[:name_ja].matches(exact_keyword))
      )
    else
      @devices = Device.order(created_at: :desc).limit(10)
    end
  end

  private
  def device_params
    params.required(:device).permit(
      :images
    )
  end
end