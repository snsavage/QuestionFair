FactoryGirl.define do  

  factory :user do
    nickname "test_user"
    email "example@questionfair.com"
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