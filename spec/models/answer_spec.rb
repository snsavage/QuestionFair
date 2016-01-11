require 'rails_helper'

RSpec.describe Answer do

  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    login_as @user
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
    is_expected.to validate_presence_of(:answer)
  end

  it "has maximum lenghth of 500 chars" do
    is_expected.to validate_length_of(:answer).is_at_most(500)
  end

  it "is invalid without a user" do
    answer = build(:answer, user_id: nil)
    expect(answer).to be_invalid 
  end

end


