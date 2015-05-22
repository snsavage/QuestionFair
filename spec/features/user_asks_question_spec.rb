require 'rails_helper'

describe "ask a question", type: :feature do
  it "asks a question" do
    login_as(user)
    visit new_question_path

    fill_in "Question", with: "Will this work?"
    select "Other", from: "Category"
    click_button I18n.t("helpers.submit.question.create")

    within ".question-question" do
      expect(page).to have_content "Will this work?"
    end
    expect(page).to have_content "Other"
  end

  def user
    @user ||= create(:user).tap do |user|
      user.confirm!
    end
  end
end