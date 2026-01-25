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
end