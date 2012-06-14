# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  gradyear        :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :gradyear
  
  has_secure_password
  before_save :create_remember_token

  has_many :posted_positions, class_name: 'Position', foreign_key: :poster_id
  has_one :placement, as: :placeable, dependent: :destroy
  has_one :location, through: :placement
  
  GRADYEAR_UPPER = 2016
  GRADYEAR_LOWER = 1950
  
  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  
  validates :password, length: { minimum: 6 }, if: :should_validate_password?
  
  validates :password_confirmation, presence: true, if: :should_validate_password?
  
  validate :gradyear_valid
  
  def place_in!(location_attr)
    location_record = Location.add_location!(location_attr)
    placement ? placement.update_attributes!(location_id: location_record.id) : create_placement!(location_id: location_record.id)
  end

  def remove_location!
    placement.destroy
  end

  private
  
    def should_validate_password?
      new_record? || password.present? || password_confirmation.present?
    end
    
    def gradyear_valid
      return if gradyear.nil?
      errors.add(:gradyear, "is not a valid graduation year") unless
gradyear.between?(GRADYEAR_LOWER, GRADYEAR_UPPER)
    end
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
