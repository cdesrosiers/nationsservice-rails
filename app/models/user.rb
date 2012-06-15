class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name

  has_one :profile
  has_many :authentications, dependent: :destroy
  
  # validates :name, presence: true, length: { maximum: 50 }

  def build_new_authentication(omniauth)
    authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def email_required?
    password_required?
  end 
end
