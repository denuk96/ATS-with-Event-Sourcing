require 'swagger_helper'

RSpec.describe 'Applications API', type: :request do
  let!(:active_jobs_list) { create_list(:job, 30, :with_active_event, :with_applications) }
  let!(:inactive_jobs_list) { create_list(:job, 15, :with_deactivated_event) }

  path '/applications' do
    get 'Retrieve all Applications with active jobs' do
      tags 'Applications', 'index'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, required: false, description: 'Page number for pagination'

      response '200', 'Applications page 1 retrieved' do
        schema '$ref' => '#/components/schemas/applications_array'

        # Testing the first page (default)
        run_test!
      end

      response '200', 'Applications page 2 retrieved' do
        schema '$ref' => '#/components/schemas/applications_array'

        # Testing the second page
        let(:page) { 2 }
        run_test!
      end
    end
  end
end
