FactoryBot.define do
  factory :application do
    job

    candidate_name { Faker::Name.name }

    trait :with_interview_event do
      after(:create) do |application, _evaluator|
        create(:application_event, :interview, application: application)
      end
    end

    trait :with_hired_event do
      after(:create) do |application, _evaluator|
        create(:application_event, :interview, application: application)
        create(:application_event, :hired, application: application)
      end
    end

    trait :with_rejected_event do
      after(:create) do |application, _evaluator|
        create(:application_event, :interview, application: application)
        create(:application_event, :rejected, application: application)
      end
    end

    trait :with_notes do
      after(:create) do |application, _evaluator|
        create_list(:application_notes, 5, application: application)
      end
    end
  end
end
