# frozen_string_literal: true

class Authorization < ApplicationRecord
  belongs_to :organization
  validates :uid, uniqueness: { scope: :platform }
  scope :slack, -> { where(platform: 'Slack') }
end
