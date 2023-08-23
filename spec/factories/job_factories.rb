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
  end
end
