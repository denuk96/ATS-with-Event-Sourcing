# frozen_string_literal: true

require 'rails_helper'
require 'rswag'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'ATS with Event Sourcing',
        version: '0.0.1'
      },
      servers: [
        {
          url: 'http://localhost:3000'
        }
      ],
      components: {
        schemas: {
          job_properties: {
            type: :object,
            properties: {
              id: { type: :string, example: '100' },
              type: { type: :string, example: 'job' },
              attributes: {
                type: :object,
                properties: {
                  title: { type: :string, example: 'RoR dev' },
                  description: { type: :string, example: 'job description' },
                  status: { type: :string, example: 'active' },
                  hired: { type: :integer, example: 2 },
                  rejected: { type: :integer, example: 5 },
                  ongoing: { type: :integer, example: 1 }
                },
                required: %w[title description status hired rejected ongoing]
              }
            },
            required: %w[id type attributes]
          },
          jobs_array: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  '$ref' => '#/components/schemas/job_properties'
                }
              }
            },
            required: %w[data]
          },
          application_properties: {
            type: :object,
            properties: {
              id: { type: :string, example: '100' },
              type: { type: :string, example: 'job' },
              attributes: {
                type: :object,
                properties: {
                  candidate_name: { type: :string, example: 'Denys Taradada' },
                  status: { type: :string, example: 'active' },
                  job_name: { type: :string, example: 'Ruby Dev' },
                  first_interview_date: { type: :string, format: 'date-time', example: '2023-08-26T08:20:47.418Z' },
                  notes_count: { type: :integer, example: 5 }
                },
                required: %w[candidate_name status job_name first_interview_date notes_count]
              }
            },
            required: %w[id type attributes]
          },
          applications_array: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  '$ref' => '#/components/schemas/application_properties'
                }
              }
            },
            required: %w[data]
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
