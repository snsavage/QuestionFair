require 'rails_helper'

describe "ask a question", :type => :feature  do 

  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!

    # visit new_user_session
    visit new_user_session_path
    fill_in "Email", with: @user.email 
    fill_in "Password", with: @user.password 
    click_button "Log in"
  end

  it "asks a question" do



    visit new_question_path



    fill_in "Question", with: "Will this work?"
    select "Category", from: "Other"
    click_button "Ask Question"

    expect(page).to have_content "Will this work?"


  end

end