class PositionsController < ApplicationController
  def show
    @position = Position.find(params[:id])
  end
  
  def index
    @positions = Position.paginate(page: params[:page])
  end
end
