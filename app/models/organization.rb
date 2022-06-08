# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :authorizations, dependent: :destroy
  validates :name, presence: true

  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.emoji = ':taco:'
    self.daily_budget = 5
  end
end
