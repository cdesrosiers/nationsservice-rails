class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Nations' Service!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @selected_institution = Institution.new
    @institutions = []
  end
  
  def update
    user_params = params[:user]
    
    if params[:selected_institution][:id].present?
      user_params[:institution_id] = params[:selected_institution][:id]
      
      if params[:selected_campus].present? && params[:selected_campus][:id].present?
        user_params[:campus_id] = params[:selected_campus][:id]
      else
        user_params[:campus_id] = nil
      end
    end
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      @selected_institution = Institution.new
      @institutions = []
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  # AJAX actions ---------------------------------------------------
  
  def update_institutions_list
    #update the institutions list based on the selected state
    if(params[:state].present?)
      @institutions = Institution.where("state = ?", params[:state]).order(:name)
    else
      @institutions = []
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  def update_campuses_list
    #update the campuses list based on the selected institution
    if(params[:ins].present?)
      @campuses = Campus.where("institution_id = ?", params[:ins])
      @selected_campus = Campus.new
    else
      @campuses = []
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  # private methods ----------------------------------------------------
  
  private
  
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
       redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
