# frozen_string_literal: true

Rails.application.routes.draw do
  scope :slack do
    post 'events', to: 'slack#events'
    get 'authorize', to: 'slack#authorize'
  end

  resource :organization, only: %i[show edit update]

  root 'home#index'
end
