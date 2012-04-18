# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :institution, :campus, :gradyear, :institution_id, :campus_id
  attr_accessor :updating_password
  
  has_secure_password
  before_save :create_remember_token
  belongs_to :institution
  belongs_to :campus
  has_many :posted_positions, class_name: 'Position', foreign_key: :posted_by
  
  GRADYEAR_UPPER = 2016
  GRADYEAR_LOWER = 1950
  
  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  
  validates :password, length: { minimum: 6 }, if: :should_validate_password?
  
  validates :password_confirmation, presence: true, if: :should_validate_password?
  
  validate :gradyear_valid
  
  validate :institution_valid
  
  def should_validate_password?
    updating_password || new_record? || (!password.nil? && !password.blank?) || (!password_confirmation.nil? && !password_confirmation.blank?)
  end
  
  def gradyear_valid
    errors.add(:gradyear, "Please select a valid graduation year") if (!gradyear.nil? and (gradyear < GRADYEAR_LOWER or gradyear > GRADYEAR_UPPER))
  end
  
  def institution_valid
    institution_rec = Institution.find_by_id(institution_id)
    campus_rec = institution_rec.nil? ? nil : institution_rec.campuses.find_by_id(campus_id)
    
    errors.add(:institution_id, "Invalid institution/campus combination") if (institution_rec.nil? and !institution_id.nil?) or (campus_rec.nil? and !campus_id.nil?)
  end
  
  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
