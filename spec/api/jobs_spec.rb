require 'swagger_helper'

RSpec.describe 'Jobs API', type: :request do
  let!(:active_jobs_list) { create_list(:job, 15, :with_active_event) }
  let!(:inactive_jobs_list) { create_list(:job, 15, :with_deactivated_event) }

  path '/jobs' do
    get 'Retrieve all jobs with their associated metrics' do
      tags 'Jobs', 'index'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, required: false, description: 'Page number for pagination'

      response '200', 'Jobs with metrics retrieved' do
        schema '$ref' => '#/components/schemas/jobs_array'

        # Testing the first page (default)
        run_test!
      end

      response '200', 'Jobs with metrics retrieved from second page' do
        schema '$ref' => '#/components/schemas/jobs_array'

        # Testing the second page
        let(:page) { 2 }
        run_test!
      end
    end
  end
end
