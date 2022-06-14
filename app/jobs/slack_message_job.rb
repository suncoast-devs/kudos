# frozen_string_literal: true

class SlackMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @event = args.first

    receivers.each do |receiver|
      giver.given_conferrals.create!(receiver: receiver)
    end

    @event.completed!
  end

  private

  def text_elements
    @text_elements ||= @event.data['event']['blocks']
                             .first { |block| block['type'] == 'rich_text' } ['elements']
                             .first { |element| element['type'] == 'rich_text_section' }['elements']
  end

  def receivers
    @receivers ||= text_elements.select { |element| element['type'] == 'user' }.map do |element|
      organization.personas.slack.find_or_create_by!(uid: element['user_id'])
    end
  end

  def giver
    @giver ||= organization.personas.slack.find_or_create_by!(uid: @event.data.dig('event', 'user'))
  end

  def organization
    @organization ||= @organization = Authorization.slack.find_by(uid: @event.data.dig('event', 'team'))&.organization
  end
end
