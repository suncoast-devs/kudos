# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SlackMessageJob, type: :job do
  before do
    organization = Organization.create(name: 'SDG')
    organization.authorizations.slack.create(uid: 'T7HH5AJ56')
  end

  let(:event) do
    Event.slack.new(data: { 'event' => {
                      'team' => 'T7HH5AJ56',
                      'user' => 'U7K9DSQ0P',
                      'blocks' => [{ 'type' => 'rich_text',
                                     'elements' => [{
                                       'type' => 'rich_text_section',
                                       'elements' => [
                                         { 'type' => 'text', 'text' => 'Great job on the stuff you did ' },
                                         { 'type' => 'user', 'user_id' => 'UCJN5788J' },
                                         { 'type' => 'text', 'text' => ', have a ' },
                                         { 'type' => 'emoji', 'name' => 'taco' },
                                         { 'type' => 'text', 'text' => '!' }
                                       ]
                                     }] }]
                    } })
  end

  it 'Creates new personas for giver and receiver(s)' do
    expect { SlackMessageJob.new.perform(event) }.to change { Persona.count }.by(2)
  end

  it 'Creates conferrals' do
    expect { SlackMessageJob.new.perform(event) }.to change { Conferral.count }.by(1)
  end
end
