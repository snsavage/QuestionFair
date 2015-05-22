module QuestionsHelper

  def user_has_answered(answers)
    answers.pluck(:user_id).include?(current_user.id)
  end  

  def voted_on_answer(answer)
    answer.answer_votes.pluck(:user_id).include?(current_user.id)
  end

  def voted_on_question(question)
    question.answer_votes.pluck(:user_id).include?(current_user.id)
  end

end
