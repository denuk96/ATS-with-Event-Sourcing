FactoryBot.define do
  factory :job_event, class: 'JobRelated::Event' do
    job

    trait :active do
      status { :active }
    end

    trait :deactivated do
      status { :deactivated }
    end
  end
end
