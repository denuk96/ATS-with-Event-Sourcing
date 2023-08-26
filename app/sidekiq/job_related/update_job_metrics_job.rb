module JobRelated
  class UpdateJobMetricsJob
    include Sidekiq::Job

    def perform(job_id)
      Job.find(job_id).update_metrics!
    end
  end
end
