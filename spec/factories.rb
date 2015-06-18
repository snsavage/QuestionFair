FactoryGirl.define do  

  factory :user do
    sequence(:nickname) { |n| "test_user-#{n}" }
    sequence(:email) { |n| "example-#{n}@questionfair.com" }
    password "long_secret"
    password_confirmation "long_secret"
    terms true
  end

  factory :answerer, class: :user do
    nickname "answering_user"
    email "answeringuser@questionfair.com"
    password "long_secret"
    password_confirmation "long_secret"
    terms true
  end

  factory :answer_vote do
    answer
    user
  end 

  factory :question do
    question "A question?"
    category "Other"

    factory :invalid_question do
      question nil
      category nil
    end

  end

  factory :answer do
    association :question
    answer "An answer!"

    factory :invalid_answer do
      answer nil
    end
  end

end