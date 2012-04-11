class Institution < ActiveRecord::Base
  attr_accessible :name, :state
  has_many :campuses, class_name: 'Campus', dependent: :destroy
  has_many :users
  has_many :positions
end
