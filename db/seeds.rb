require 'factory_bot'
require 'faker'

Dir[Rails.root.join('spec/factories/**/*.rb')].sort.each { |f| require f }

include FactoryBot::Syntax::Methods

create_list(:job, 10, :with_active_event, :with_applications)
create_list(:job, 5, :with_deactivated_event, :with_applications)
create_list(:job, 5)
