# frozen_string_literal: true

class Conferral < ApplicationRecord
  belongs_to :giver, class_name: 'Persona', inverse_of: :given_conferrals
  belongs_to :receiver, class_name: 'Persona', inverse_of: :received_conferrals
end
