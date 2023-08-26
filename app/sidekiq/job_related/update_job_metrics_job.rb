module JobRelated
  class UpdateJobMetricsJob
    include Sidekiq::Job
    sidekiq_options retry: false

    def perform(job_id)
      Job.find(job_id).update_metrics!
    end
  end
end
