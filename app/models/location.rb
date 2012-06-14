# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  country    :string(255)
#  state      :string(255)
#  city       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Location < ActiveRecord::Base
  attr_accessible :country, :state, :city
  has_many :placements, dependent: :destroy
  has_many :positions, through: :placements
  has_many :users, through: :placements

  validate :country, :presence

  def self.add_location!(*attributes)

    options = attributes.extract_options!
    location_attr = options.slice(*_attribute_keys)
    raise ArgumentError, "You need to specify at least one location attribute" if location_attr.empty?
    
    records = where(_location_zero.merge(location_attr))

    case records.count
      when 0
        create!(location_attr)
      when 1
        records.first
      when records.count > 1
        # we really don't expect to get here, but if we do...
        new_location = create!(location_attr)
        warn %(warning: Location.add_location! : ambiguous locations found
          id=#{records.map(&:id)}. Created new location id=#{new_location.id})
        new_location
    end
  end
  
  def remove_abandoned
#    abandoned_ids = Location.all.select(:id).map(&:id) 
#      - Placement.all.select(:location_id).map(&:location_id)
#    
#    Location.where(id: abandoned_ids).destroy_all
  end
  
  def valid_state
    return if state.blank? or country.blank?
    errors.add(:state, "is not a valid state/province for this country") unless has_state?
    errors.add(:state, "is chosen for a country that has no states/provinces") unless has_states?
  end

  def has_states?
    begin
      Carmen.state_codes(country).length > 0
    rescue
      false
    end
  end

  def has_state?
    begin
      Carmen.state_codes(country).include?(state)
    rescue
      false
    end
  end
      
  private
  
    def self._location_zero
      {country: "", city: "", state: ""}
    end
    
    def self._attribute_keys
      _location_zero.keys
    end
    
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
