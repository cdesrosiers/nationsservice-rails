# == Schema Information
#
# Table name: positions
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  deadline      :date
#  poster_id     :integer
#  position_type :integer(2)
#  duration      :integer(2)
#  overview      :string(2047)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Position < ActiveRecord::Base
  attr_accessible :name, :description, :deadline, :position_type, :duration,
    :overview
  
  belongs_to :poster, class_name: 'User'
  
  has_many :placements, as: :placeable, dependent: :destroy
  
  has_many :locations, through: :placements
  
  validates :name, presence: true
  
  validates :position_type, presence: true
    # 1=fellowship, 2=internship, 3=job, 0=other
  
  validates :description, presence: true
  
  validates :overview, length: { maximum: 2047 }

  validates :poster_id, presence: true
  
  def place_in!(location_attr)
    location_record = Location.add_location!(location_attr)
    placements.create!(location_id: location_record.id) unless placed_in?(location_record)
  end

  def placed_in?(location_record)
    placements.find_by_location_id(location_record.id).present?
  end
  
  def remove_from!(location_record)
    placements.find_by_location_id(location_record.id).destroy
  end
end
