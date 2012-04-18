class PositionsController < ApplicationController
  include PositionsHelper
  
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
    prefill_location_field
    prefill_institution_field
  end
  
  def update
    @position = Position.find_by_id(params[:id])
    place_in_locales
    if @position.update_attributes(params[:position])
      flash[:success] = "Position updated"
      redirect_to @position
    else
      prefill_location_field
      prefill_institution_field
      render 'edit'
    end
  end
  
  def new
    @position = Position.new
    prefill_location_field
    prefill_institution_field
  end
  
  def create
    @position = @current_user.posted_positions.build(params[:position])
    if @position.save
      place_in_locales
      flash[:success] = "New position added"
      redirect_to @position
    else
      prefill_location_field
      prefill_institution_field
      render 'new'
    end
  end
  
  def destroy
    Position.find(params[:id]).destroy
    flash[:success] = "Position destroyed."
    redirect_to positions_path
  end
  
  private
  
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    
    def prefill_location_field
      @countries = Carmen.countries
      
      @provinces = []
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
    
    def place_in_locales
      if params[:locales].present?
        locale_recs = []
        for locale in params[:locales] do
          locale_rec = Locale.find(:first, conditions: locale)
          
          if locale_rec.nil?
            locale_rec = Locale.create(locale)
          end
          
          locale_recs.append(locale_rec) unless locale_rec.nil?
        end
        
        for locale_rec in locale_recs do
          @position.place_in(locale_rec) unless @position.placed_in?(locale_rec)
        end
      end
    end
end
