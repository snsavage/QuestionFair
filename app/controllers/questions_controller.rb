class QuestionsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :search, :geo_search]

  load_and_authorize_resource :question, except: [:index]
  skip_authorization_check only: [:index, :show, :geo_search]

  add_breadcrumb "Home", :root_path

  # def search

  #   add_breadcrumb "Search", :search_questions_path

  #   @questions = Question.search_all(params[:search]).page(params[:page]).order('created_at DESC').per_page(20)

  # end

  def geo_search

    @locations = Question.select(:city_state).where("city_state ILIKE ?", "%#{params[:term]}%").group(:city_state)
    respond_to do |format|
      format.json { render json: @locations.map(&:city_state) }
      format.html { redirect_to root_path }
    end

  end

  def index
    add_breadcrumb "Browse", :questions_path

    @search_questions = SearchQuestions.new(search_params || {})
  end

  def show
    add_breadcrumb "Browse", :questions_path
    add_breadcrumb "View Question", :question_path

    @question = QuestionPresenter.new(Question.find(params[:id]))
  end

  def new
    add_breadcrumb "Ask Question"
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
    add_breadcrumb "Browse", :questions_path
    add_breadcrumb "View Quesiton", question_path(@question)
    add_breadcrumb "Edit Question"
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      @question.create_activity :create, owner: current_user
      reward_points @question, :ask
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    remove_points @question

    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:question, :category, :address)
    end

    def search_params
      params.permit(:location, :category, :distance, :page, :query)
    end
end
