class BestsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.best = true
    if @answer.save
      @question.create_activity :best, owner: current_user
      reward_best_points @question, @answer
      redirect_to :back, notice: "Thank you for selecting a best answer."
    else
      redirect_to :back, notice: "Your selection could not be saved."
    end
  end
end