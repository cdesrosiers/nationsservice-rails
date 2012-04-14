class AjaxController < ApplicationController
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
  
  def update_provinces_list
    if(params[:country_code].present?)
      begin
        @provinces = Carmen.states(params[:country_code])
      rescue
        @provinces = []
      end
    end
    
    @elem_id = params[:elem_id].present? ? params[:elem_id] : ""
  end
end
