FactoryBot.define do
  factory :application_event, class: 'ApplicationRelated::Event' do
    application

    trait :interview do
      status { :interview }
    end

    trait :hired do
      status { :hired }
    end

    trait :rejected do
      status { :rejected }
    end
  end
end
