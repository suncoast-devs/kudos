class SlackMessageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @event = args.first
    @organization = Authorization.slack.find_by(uid: @event.data.dig('event', 'team'))&.organization
    giver = @organization.personas.slack.find_or_create_by!(uid: @event.data.dig('event', 'user'))

    @event.data['event']['blocks']
          .first { |block| block['type'] == 'rich_text' } ['elements']
          .first { |element| element['type'] == 'rich_text_section' }['elements']
          .each do |element|
      next unless element['type'] == 'user'

      receiver = @organization.personas.slack.find_or_create_by!(uid: element['user_id'])
      # TODO: Only if the emoji is correnct.
      giver.given_conferrals.create!(receiver: receiver)
    end

    @event.completed!
  end
end
