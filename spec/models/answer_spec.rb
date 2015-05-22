require 'rails_helper'

RSpec.describe Answer do

  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    sign_in @user

    @answerer = FactoryGirl.create(:answerer)
    @answerer.confirm!
    sign_in @answerer
  end

  it "is valid with a valid question" do
    question = create(:question, user_id: @user.id)
    answer = build(:answer, question_id: question.id)
    expect(answer).to be_valid
  end

  it "belongs to question" do
    is_expected.to belong_to(:question)
  end

  it "has a question_id" do
    is_expected.to validate_presence_of(:question)
  end

  it "has an answer" do
    answer = build(:answer, answer: nil)
    expect(answer).to_not be_valid
  end

  it "has maximum lenghth of 500 chars" do
    answer = build(:answer, answer: 'q'*501)
    expect(answer).to_not be_valid
  end

  # Test for missing validation on question requiring a user.
  it "is invalid without a user" do
    answer = build(:answer, user_id: nil)
    expect(answer).to_not be_valid
  end

end


