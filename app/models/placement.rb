class Placement < ActiveRecord::Base
  attr_accessible :locale_id
  belongs_to :position
  belongs_to :locale
  
  validates :locale_id, presence: true
  validates :position_id, presence: true
end
