# frozen_string_literal: true

class SlackReactionAddedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @event = args.first
    # DO WORK HERE
    @event.completed!
  end
end
