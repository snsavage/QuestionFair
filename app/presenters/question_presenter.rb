class QuestionPresenter < SimpleDelegator
  def initialize(question, params = {})
    super(question)
    @params = params
  end

  def new_answer
    @answer ||= answers.build(params)
  end

  def save_answer
    new_answer.save
  end

  def create_answer_activity
    new_answer.create_activity
  end

  def time_created
    created_at.strftime('%A, %B %d, %Y at %I:%M %p EST')
  end

  def any_answers?
    answers.any? { |answer| answer.persisted? }
  end

  private

  attr_reader :params
end