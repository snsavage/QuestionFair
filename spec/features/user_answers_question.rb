require 'rails_helper'

describe "answer a question", type: :feature do

  before(:each) do
    @user_asks_question = user
    @question = FactoryGirl.create(:question)
  end

  



  def user
    @user ||= FactoryGirl.create(:user).tap do |user|
      user.comfirm!
    end
  end

end