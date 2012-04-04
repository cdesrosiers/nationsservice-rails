class Campus < ActiveRecord::Base
  attr_accessible :name
  validates :institution_id, presence: true
  belongs_to :institution
  default_scope order: 'campus.name'
end
