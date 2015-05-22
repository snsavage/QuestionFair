module AnswersHelper
  def can_answer_question?(user)
    can?(:create, @question.new_answer) && !user_has_answered(@question.answers) && !voted_on_question(@question)
  end
end
