class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :candidate_name, :status, :notes_count

  attribute :job_name do |object|
    object.job.title
  end

  # TODO: create field to store first_interview_date in applications table to avoid searching in events
  attribute :first_interview_date do |object|
    object.events
          .select { |e| e.status == 'interview' }
          .min { |e| e.created_at.to_i }
  end
end
