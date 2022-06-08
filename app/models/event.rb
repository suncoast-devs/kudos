# frozen_string_literal: true

class Event < ApplicationRecord
  enum status: { pending: 0, processing: 1, completed: 2, failed: 3 }
end
