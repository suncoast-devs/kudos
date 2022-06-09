# frozen_string_literal: true

class Persona < ApplicationRecord
  belongs_to :organization
  has_many :given_conferrals, class_name: 'Conferral', foreign_key: 'giver_id', dependent: :destroy,
                              inverse_of: :giver
  has_many :received_conferrals, class_name: 'Conferral', foreign_key: 'receiver_id', dependent: :destroy,
                                 inverse_of: :receiver
  scope :slack, -> { where(platform: 'Slack') }
end
