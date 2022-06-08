class EventDispatchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @event = args.first
    @event.processing!

    if @event.platform == 'Slack'
      case @event.dig('event', 'type')
      when 'reaction_added'
        ReactionAddedJob.perform_later(@event)
      else
        raise "Unsupported event type: #{@event.dig('event', 'type')}"
      end
    else
      raise "Unsupported platform: #{@event.platform}"
    end
  end
end
