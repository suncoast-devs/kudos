# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  it 'has a default emoji' do
    expect(subject.emoji).to eq('taco')
  end

  it 'has a default daily budget' do
    expect(subject.daily_budget).to eq(5)
  end
end
