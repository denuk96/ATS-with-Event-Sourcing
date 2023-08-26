FactoryBot.define do
  factory :application_notes, class: 'ApplicationRelated::Note' do
    application
    content { Faker::Lorem.paragraph }
  end
end
