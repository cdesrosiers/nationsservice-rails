class PositionsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :new, :create]
  
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
  
  def edit
    @position = Position.find_by_id(params[:id])
    prefill_institution_field
  end
  
  def update
    @position = Position.find_by_id(params[:id])
    if @position.update_attributes(params[:position])
      flash[:success] = "Position updated"
      redirect_to @position
    else
      prefill_institution_field
      render 'edit'
    end
  end
  
  def new
    @position = Position.new
    prefill_institution_field
  end
  
  def create
    @position = @current_user.posted_positions.build(params[:position])
    if @position.save
      flash[:success] = "New position added"
      redirect_to @position
    else
      prefill_institution_field
      render 'new'
    end
  end
  
  private
  
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    
    def prefill_institution_field
      if @position.institution_id.nil?
        @selected_institution = Institution.new
        if(params[:selected_institution].present? && params[:selected_institution][:state].present?)
          @selected_institution.state = params[:selected_institution][:state]
          @institutions = Institution.where("state = ?", @selected_institution.state).order(:name)
        else
          @institutions = []
        end
        @campuses = []
      else
        @selected_institution = Institution.find_by_id(@position.institution_id)
        @institutions = Institution.where("state = ?", @selected_institution.state).order(:name)
        @campuses = @selected_institution.campuses.any? ? @selected_institution.campuses : []
      end
    
      @states = Institution.select(:state).uniq.reorder(:state)
    end
end
