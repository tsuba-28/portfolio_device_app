class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @desk_setups = current_user.favorite_desk_setups
  end
end