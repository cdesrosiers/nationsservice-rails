class Locale < ActiveRecord::Base
  attr_accessible :country, :province, :city
  has_many :placements, dependent: :destroy
  has_many :positions, through: :placements
  
  validate :should_have_province_selected_if_possible
  validate :should_not_have_province_selected_if_impossible
  validate :should_have_valid_province
  validate :country, :presence
  
  # don't allow locales in which a country and city are specified without a province, if the the country has provinces
  # this check avoids having redundant locales like (Atlanta, GA, USA) and (Atlanta, USA)
  # this also avoids ambiguity like (Portland, USA) which may refer to either (Portland, OR, USA) or (Portland, ME, USA)
  def should_have_province_selected_if_possible
    errors.add(:province, "Please choose a state/province for this locale") if (has_provinces and (province.nil? or province.blank?) and (!city.nil? and !city.blank?))
  end
  
  def should_have_valid_province
    if has_provinces and (!province.nil? and !province.blank?)
      errors.add(:province, "Please choose a valid state/province for this locale") if !Carmen.state_codes(country).include?(province)
    end
  end
      
  def should_not_have_province_selected_if_impossible
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
