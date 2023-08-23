# frozen_string_literal: true

class JobSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :status
end
