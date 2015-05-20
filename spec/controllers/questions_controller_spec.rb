require 'rails_helper'

RSpec.describe QuestionsController do

  describe 'GET #index' do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end

    it "returns an array of all questions" do
      first_question = Question.create(question: "The first question?", category: "Other", user_id: @user.id) # fix this
      second_question = Question.create(question: "The second question?", category: "Other", user_id: @user.id) # fix this
      get :index
      expect(assigns(:questions)).to match_array([first_question, second_question])    
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end

    it "assigns the requested question to @question" do
      question  = create(:question, user_id: @user.id)
      get :show, id: question
      expect(assigns(:question)).to eq question
    end

    it "renders the show template" do
      question = create(:question, user_id: @user.id)
      get :show, id: question
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm!
      sign_in @user
    end

    it "assigns a new question to @question" do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @user
    end

    it "assigns the requested question to @question" do
      question = create(:question, user_id: @user.id)
      get :edit, id: question
      expect(assigns(:question)).to eq question
    end

    it "renders the :edit template" do
      question = create(:question, user_id: @user.id)
      get :edit, id: question
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @user
    end

    context "with valid attributes" do
      it "saves the new question to the database" do
        expect{
          post :create, question: attributes_for(:question)
        }.to change(Question, :count).by(1)
      end

      it "redirects to question#show" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns[:question])
      end
    end

    context "with invalid attributes" do
      it "does not save the new question to the database" do
        expect{
          post :create, question: attributes_for(:invalid_question)
        }.not_to change(Question, :count)
      end

      it "re-renders the :new template" do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do

      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @user

      @question = create(:question, question: "An updated question?", category: "Other", user_id: @user.id)
    end

    context "valid attributes" do

      it "finds the requested @question" do
        patch :update, id: @question, question: attributes_for(:question)
        expect(assigns(:question)).to eq(@question)
      end

      it "changes @question's attributes" do
        patch :update, id: @question, 
          question: attributes_for(:question, question: "Another updated question?", category: "Other")
        @question.reload
        expect(@question.question).to eq('Another updated question?')
        expect(@question.category).to eq('Other')
      end

      it "redirects to the updated question" do
        patch :update, id: @question, question: attributes_for(:question)
        expect(response). to redirect_to @question
      end
    end

    context "with invalid attributes" do
      it "does not change the contact's attributes" do
        patch :update, id: @question, question: attributes_for(:question, question: nil, category: nil)
        @question.reload
        expect(@question.question).to eq("An updated question?")
        expect(@question.category).to eq("Other")
      end

      it "re-renders the :edit template" do
        patch :update, id: @question, question: attributes_for(:invalid_question)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @user

      @question = create(:question, user_id: @user.id)
    end

    it "deletes the question" do
      expect{ delete :destroy, id: @question }.to change(Question, :count).by(-1)
    end

    it 'redirects to questions#index' do
      delete :destroy, id: @question
      expect(response).to redirect_to questions_url
    end
  end

end
