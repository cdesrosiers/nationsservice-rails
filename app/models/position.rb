class Position < ActiveRecord::Base
  attr_accessible :name, :description, :location_city, :location_state, :location_country, :deadline, :logo_path, :position_type, :institution_id, :campus_id, :institution, :campus, :duration, :overview
  belongs_to :poster, class_name: 'User', foreign_key: :posted_by
  belongs_to :institution
  belongs_to :campus
  has_many :placements, dependent: :destroy
  has_many :locales, through: :placements
  
  validates :name, presence: true #, length: {maximum: 50}
  validates :position_type, presence: true # 1=fellowship, 2=internship, 3=job, 0=other
  validates :description, presence: true
  validates :overview, length: { maximum: 1024 }
  
  def try_deadline
    deadline? ? deadline : Date.new
  end
  
  def placed_in?(locale)
    placements.find_by_locale_id(locale.id)
  end
  
  def place_in!(locale)
    placements.create!(locale_id: locale.id)
  end
  
  def place_in(locale)
    placements.create(locale_id: locale.id)
  end
  
  def remove_from!(locale)
    placements.find_by_locale_id(locale.id).destroy
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
