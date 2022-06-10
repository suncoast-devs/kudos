# frozen_string_literal: true

class EventDispatchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @event = args.first
    @event.processing!

    raise "Unsupported platform: #{@event.platform}" unless @event.platform == 'Slack'

    event_type = @event.data.dig('event', 'type')
    case event_type
    when 'reaction_added', 'reaction_removed', 'message'
      "Slack#{event_type.camelize}Job".constantize.perform_later(@event)
    else
      raise "Unsupported event type: #{event_type}"
    end
  end
end
