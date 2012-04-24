class Locale < ActiveRecord::Base
  attr_accessible :country, :province, :city
  has_many :placements, dependent: :destroy
  has_many :positions, through: :placements
  
  validate :should_have_province_selected_if_possible
  validate :should_not_have_province_selected_if_impossible
  validate :should_have_valid_province
  validate :country, :presence

  before_save :create_strrep

  default_scope order: 'locales.city'

  def create_strrep
    self.strrep = "#{city_name} #{province_name} #{country_name}"
  end
  
  # Don't allow locales in which a country and city are specified without a
  # province, if the country has provinces. This check avoids having 
  # redundant locales like (Atlanta, GA, USA) and (Atlanta, USA). This also
  # avoids ambiguity like (Portland, USA) which may refer to either 
  # (Portland, OR, USA) or (Portland, ME, USA)

  def should_have_province_selected_if_possible
    errors.add(:province, "Please choose a state/province for this locale") if 
      (has_provinces and (province.nil? or province.blank?) and (!city.nil? and !city.blank?))
  end
  
  def should_have_valid_province
    if has_provinces and (!province.nil? and !province.blank?)
      errors.add(:province, "Please choose a valid state/province for this locale") if
        !Carmen.state_codes(country).include?(province)
    end
  end
      
  def should_not_have_province_selected_if_impossible
    errors.add(:province, "There are no states/provinces available for this country") if
      (!has_provinces and !(province.nil? or province.blank?))
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

    def country_name 
      begin
        Carmen.country_name(country)
      rescue
        ''
      end
    end

    def province_name 
      begin
        Carmen.state_name(province)
      rescue
        ''
      end
    end

    def city_name 
      begin
        city
      rescue
        ''
      end
    end
end
