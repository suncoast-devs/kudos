require 'rails_helper'

RSpec.describe EventDispatchJob, type: :job do
  let(:event) do
    Event.slack.new(data: { 'type' => 'event_callback',
                            'event' => { 'type' => 'message' } })
  end

  it 'dispaches a job based on type' do
    expect do
      EventDispatchJob.perform_now(event)
    end.to have_enqueued_job(SlackMessageJob)
  end
end
