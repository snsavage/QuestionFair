require 'rails_helper'

describe "ask a question", type: :feature do

  it "displays the asked question" do
    login_and_ask_question
    within(".question-question") { expect(page).to have_content "Will this work?" }
  end

  it "displays the question category" do
    login_and_ask_question
    within(".question-category") { expect(page).to have_content "Other" }
  end

  it "displays the askers nickname" do
    login_and_ask_question
    within(".question-nickname") { expect(page).to have_content @user.nickname }
  end

  it "displays zero answer count" do
    login_and_ask_question
    within(".question-count") { expect(page).to have_content "0" }
  end

  it "displays no answers provided" do
    login_and_ask_question
    within(".question-no-answers") { expect(page).to have_content "No answers have been provided." }
  end

  it "provides question controls" do
    login_and_ask_question
    within(".question-controls") { expect(page).to have_content "Question Controls" }
  end

  it "allows users to edit question" do
    login_and_ask_question
    within(".question-edit-delete") {expect(page).to have_content "Edit Question" }
  end

  it "allows users to delete question" do
    login_and_ask_question
    within(".question-edit-delete") {expect(page).to have_content "Delete Question" }
  end

  def login_and_ask_question
    login_as(user)
    visit new_question_path
    fill_in "Question", with: "Will this work?"
    select "Other", from: "Category" 
    click_button "Ask"
  end

  def user
    @user ||= FactoryGirl.create(:user).tap do |user|
      user.confirm!
    end
  end

end