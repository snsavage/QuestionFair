class Question < ActiveRecord::Base

  include PgSearch
  include PublicActivity::Common

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.state = geo.state_code
      obj.country = geo.country_code
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      if obj.city.present? && obj.state.present? && obj.country.present?
        obj.city_state = "#{geo.city}, #{geo.state_code}, #{geo.country_code}"
      end
    end
  end

  after_validation :geocode, if: :can_geocode?

  # after_validation :geocode

  belongs_to :user, touch: true
  has_many :answers 
  has_many :answer_votes, through: :answers

  CATEGORIES = ['Automotive','Books','Business','Cooking','Dining','Health & Fitness',
    'Movies & TV','Music','Other','Outdoors','Parenting','Pets','Sports','Technology',
    'Things to Do','Travel']

  validates :user_id, :question, :category, presence: true
  validates :question, length: { maximum: 500 }
  validates :category, inclusion: { in: CATEGORIES }

  # Source: http://blog.plataformatec.com.br/2013/02/active-record-scopes-vs-class-methods/
  scope :by_category, -> category { 
    if category == "All"
      all
    elsif category_in_categories?(category)
      where(category: category)
    else
      all
    end
  }

  scope :by_location, -> location, distance { near(location, distance) if location.present? && distance.present? }

  scope :search, -> search { 
    # where("question ILIKE ? OR category ILIKE ?", "%#{search}%", "%#{search}%")
    where("question @@ ? OR category @@ ?", search, search)
  }

  pg_search_scope :search_all, 
    against: [:question, :category, :city, :state, :country], 
    associated_against: { answers: :answer },
    using: { tsearch: { any_word: true } }
    #using: [:tsearch, :trigram, :dmetaphone]


  # scope :by_location, -> location, distance {
  #   if location.present? && distance.present?
  #     near(location, distance)
  #   else
  #     all
  #   end
  # }

  def self.newest
    order(created_at: :desc)
  end

  def create_address
    "#{city}, #{state}, #{country}"
  end

  def can_geocode?
    address? && address_changed?
  end

  def has_address?
    city? && state? && country?
  end

  def self.distances
    [[1, 1], [5, 5], [10, 10], [25, 25], [50, 50], [100, 100]]
  end 

  def self.get_stored_location(location)
    Question.select(:latitude, :longitude).find_by(city_state: location)
  end

  def self.category_list
    CATEGORIES
  end

  def self.category_list_with_all
    CATEGORIES + ["All"]
  end

  def self.category_in_categories?(category)
    category_list.include?(category)
  end

  def has_best_answer?
    answers.where(best: true).exists?
  end

  # Source: https://github.com/Casecommons/pg_search/issues/49
  def self.full_text(query)
    if query.present?
      search_all(query).newest
    else
      newest
    end
  end
end
