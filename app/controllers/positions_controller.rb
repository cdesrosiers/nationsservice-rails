class PositionsController < ApplicationController
  def show
    @position = Position.find(params[:id])
  end
  
  def index
    @positions = Position.paginate(page: params[:page])
  end
  
  def index_calview
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @positions = Position.where("date_part('month', deadline) = ?", @date.month)
  end
end
