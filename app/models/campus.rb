class Campus < ActiveRecord::Base
  attr_accessible :name
  validates :institution_id, presence: true
  belongs_to :institution
  has_many :users
  has_many :positions
  default_scope order: 'campus.name'
end
