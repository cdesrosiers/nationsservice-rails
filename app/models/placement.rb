# == Schema Information
#
# Table name: placements
#
#  placeable_id   :integer
#  placeable_type :string(255)
#  location_id    :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class Placement < ActiveRecord::Base
  attr_accessible :location_id
  belongs_to :placeable, polymorphic: true
  belongs_to :location
  
  validates :location_id, presence: true
  validates :placeable_id, presence: true
end
