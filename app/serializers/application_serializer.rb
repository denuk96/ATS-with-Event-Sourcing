class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :candidate_name, :status, :notes_count, :first_interview_date, :job_name
end
