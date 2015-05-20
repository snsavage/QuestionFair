require 'rails_helper'

RSpec.describe AnswersController do

  describe 'POST #create' do
    context "without @question" do
      it "does not save the answer" do
      end
    end

    context "with valid attributes" do
      before :each do
        # @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
        sign_in @user

        @answerer = FactoryGirl.create(:answerer)
        @answerer.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
        sign_in @answerer

        @question = create(:question, user_id: @user.id)
        @answer_attributes = attributes_for(:answer, question_id: @question, user_id: @answerer.id)
      end

      it "saves the new answer to the database" do
        expect{
          post :create, question_id: @question, answer: @answer_attributes
        }.to change(Answer, :count).by(1)
      end

      it "redirects to question#show" do
        post :create, question_id: @question, answer: @answer_attributes
        expect(response).to redirect_to(@question)
      end
    end

    context "with invalid attributes" do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        sign_in @user

        @answerer = FactoryGirl.create(:answerer)
        @answerer.confirm!
        sign_in @answerer

        @question = create(:question, user_id: @user.id)
        @answer_attributes = attributes_for(:invalid_answer, question_id: @question, user_id: @answerer.id)
      end

      it "re-renders question#edit" do
        post :create, question_id: @question, answer: @answer_attributes
        expect(response).to render_template(:edit)
      end
    end

  end


  
end