class Position < ActiveRecord::Base
  attr_accessible :name, :description, :deadline, :position_type,
    :institution_id, :campus_id, :institution, :campus, :duration, :overview,
    :logo_path 
  
  belongs_to :poster, class_name: 'User', foreign_key: :posted_by
  
  belongs_to :institution
  
  belongs_to :campus
  
  has_many :placements, dependent: :destroy
  
  has_many :locales, through: :placements
  
  validates :name, presence: true
  
  validates :position_type, presence: true
    # 1=fellowship, 2=internship, 3=job, 0=other
  
  validates :description, presence: true
  
  validates :overview, length: { maximum: 1024 }

  #validates :posted_by, presence: true
  
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

  # names of sortable fields not explicitly in the positions table
  EXTRA_SORT_FIELDS = %w[institution poster location]

  define_index do
    indexes overview
    indexes :name, sortable: true
    indexes description, sortable: true
    indexes locales.strrep, as: :location, sortable: true
    indexes poster.name, as: :poster, sortable: true
    indexes institution.name, as: :institution, sortable: true
    indexes campus.name
    has duration
    has deadline
  end
end
