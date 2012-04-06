class Position < ActiveRecord::Base
  attr_accessible :name, :description, :location_city, :location_state, :location_country, :deadline, :logo_path, :position_type
  
  validates :name, presence: true #, length: {maximum: 50}
  validates :position_type, presence: true # 1=fellowship, 2=internship, 3=job, 0=other
  validates :description, presence: true
end
