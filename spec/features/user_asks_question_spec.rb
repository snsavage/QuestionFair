require "rails_helper"

feature "user asks a question", type: :feature do

  background do
    login_and_ask_question
  end

  scenario "displays the asked question" do
    within ".question-question" do
      expect(page).to have_content "Will this work?"
    end
  end

  scenario "displays the question category" do
    within ".question-category" do
      expect(page).to have_content "Other"
    end
  end

  scenario "displays the askers nickname" do
    within ".question-nickname" do
      expect(page).to have_content user.nickname
    end
  end

  scenario "displays zero answer count" do
    within ".question-count" do
      expect(page).to have_content "0"
    end
  end

  scenario "displays no answers provided" do
    within ".question-no-answers" do
      expect(page).to have_content "No answers have been provided."
    end
  end

  scenario "provides question controls" do
    within ".question-controls" do
      expect(page).to have_content "Question Controls"
    end
  end

  scenario "allows users to edit question" do
    within ".question-edit-delete" do
      expect(page).to have_content "Edit Question"
    end
  end

  scenario "allows users to delete question" do
    within ".question-edit-delete" do
      expect(page).to have_content "Delete Question"
    end
  end
end

def login_and_ask_question
  login_as(user)
  visit new_question_path
  fill_in "Question", with: "Will this work?"
  select "Other", from: "Category"
  click_button "Ask"
end

def user
  @user ||= FactoryGirl.create(:user)
end
