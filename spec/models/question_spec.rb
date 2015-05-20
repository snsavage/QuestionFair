require 'rails_helper'

RSpec.describe Question do
  it "is valid with a valid question and category" do
    question = build(:question)
    expect(question).to be_valid
  end

  it "is invalid without a question" do
    question = build(:question, question: nil)
    expect(question).to_not be_valid
  end

  it "is invalid witout a category" do
    question = build(:question, category: nil)
    expect(question).to_not be_valid
  end

  # Test for missing validation on question requiring a user.
  it "is invalid without a user" do
    question = build(:question, user_id: nil)
    expect(question).to_not be_valid
  end

  it "has a maximum lenght of 500 chars" do
    question = Question.new(question: 'a' * 501, category: 'Other')
    expect(question).to_not be_valid
  end

  it "has a complete category list" do
    categories = ['Automotive','Books','Business','Cooking','Dining','Health & Fitness',
    'Movies & TV','Music','Other','Outdoors','Parenting','Pets','Sports','Technology',
    'Things to Do','Travel']
    expect(Question::CATEGORIES).to match_array(categories)
  end

  it "is invalid with category not in CATEGORIES" do
    question = Question.new(question: "A question?", category: "Missing Categoty")
    expect(question).to_not be_valid
  end

  it "has_many answers" do
    is_expected.to have_many(:answers)
  end

end