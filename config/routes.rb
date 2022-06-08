# frozen_string_literal: true

Rails.application.routes.draw do
  scope :slack do
    post 'events', to: 'slack#events'
    get 'authorize', to: 'slack#authorize'
  end

  resource :organization, only: %i[show edit update]

  # Limit access to dev only.
  mount GoodJob::Engine => 'q' if Rails.env.development?

  root 'home#index'
end
