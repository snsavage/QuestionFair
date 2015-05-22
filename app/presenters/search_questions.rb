class SearchQuestions
  attr_reader :query, :category, :page

  def initialize(attributes = {})
    attributes = attributes.select { |k,v| v.present? }
    @query = attributes[:query]
    @location = attributes[:location]
    @category = attributes.fetch(:category, "All")
    @distance = attributes.fetch(:distance, 10)
    @page = attributes.fetch(:page, 1)
  end

  def questions
    @questions ||= Question.includes(:user).by_location(location, distance).by_category(category).full_text(query).page(page).order('created_at DESC').per_page(20)
  end

  def location
    if stored_location
      [stored_location.latitude, stored_location.longitude]
    end
  end

  def distance
    if !Question.distances.map { |dist| dist[0] == @distance.to_i }
      @distance = 10
    end
    @distance
  end

  private

  def stored_location
    if @location
      @stored_location ||= Question.get_stored_location(@location)
    end
  end
end