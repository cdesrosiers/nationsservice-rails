class Locale < ActiveRecord::Base
  attr_accessible :country, :province, :city
  has_many :placements, dependent: :destroy
  has_many :positions, through: :placements
  
  validate :should_have_province_selected_if_possible
  validate :should_not_have_province_selected_if_impossible
  validate :country, :presence
  
  def should_have_province_selected_if_possible
    errors.add(:province, "Please choose a state/province for this locale") if (has_provinces and (province.nil? or province.blank?))
  end
      
  def should_not_have_province_selected_if_impossible
    # should never get here through browser
    errors.add(:province, "There are no states/provinces available for this country") if (!has_provinces and !(province.nil? or province.blank?))
  end
  private
    
    def has_provinces
      begin
        Carmen.states(country)
        true
      rescue
        false
      end
    end
end
