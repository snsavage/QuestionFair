FactoryGirl.define do  

  factory :user do
    sequence(:nickname) { |n| "test_user_#{n}" }
    sequence(:email) { |n| "example_#{n}@questionfair.com" }
    password "long_secret"
    password_confirmation "long_secret"
    terms true
    confirmed_at Time.now
  end

  factory :answerer, class: :user do
    nickname "answering_user"
    email "answeringuser@questionfair.com"
    password "long_secret"
    password_confirmation "long_secret"
    terms true
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