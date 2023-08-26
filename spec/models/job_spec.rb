require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '#update_metrics!' do
    let!(:job) { create(:job) }

    context 'when there are events' do
      before do
        create_list(:job_event, 3, :active, job: job)
      end

      it 'updates the status based on the latest event' do
        job.update_metrics!
        expect(job.status).to eq('active')
      end
    end

    context 'when there are no events' do
      it 'sets the status to deactivated' do
        job.update_metrics!
        expect(job.status).to eq('deactivated')
      end
    end

    context 'with applications' do
      let!(:hired_apps) { create_list(:application, 3, :with_hired_event, job: job) }
      let!(:rejected_apps) { create_list(:application, 4, :with_rejected_event, job: job) }
      let!(:ongoing_apps) { create_list(:application, 5, :with_interview_event, job: job) }

      it 'updates the hired count' do
        job.update_metrics!
        expect(job.hired).to eq(3)
      end

      it 'updates the rejected count' do
        job.update_metrics!
        expect(job.rejected).to eq(4)
      end

      it 'updates the ongoing count' do
        job.update_metrics!
        expect(job.ongoing).to eq(5)
      end
    end
  end
end
