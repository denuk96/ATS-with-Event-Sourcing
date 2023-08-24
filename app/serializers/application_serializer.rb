class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :candidate_name, :status

  attribute :job_name do |object|
    object.job.title
  end

  # TODO: optimise
  attribute :first_interview_date do |object|
    object.events
          .select { |e| e.status == 'interview' }
          .min { |e| e.created_at.to_i }
  end
end
