FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph }

    trait :with_active_event do
      after(:create) do |job, _evaluator|
        create(:job_event, :active, job: job)
      end
    end

    trait :with_deactivated_event do
      after(:create) do |job, _evaluator|
        create(:job_event, :deactivated, job: job)
      end
    end

    trait :with_applications do
      after(:create) do |job, _evaluator|
        create_list(:application, 5, :with_hired_event, :with_notes, job: job)
        create_list(:application, 5, :with_rejected_event, job: job)

        create_list(:application, 7, job: job) # applications with not statuses
        create_list(:application, 8, :with_interview_event, :with_notes, job: job)
      end
    end
  end
end
