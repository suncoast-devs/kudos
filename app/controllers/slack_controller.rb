# frozen_string_literal: true

class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def events
    render json: { challenge: params[:challenge] }
  end

  def authorize
    connection = Faraday.new(
      url: 'https://slack.com',
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    ) do |builder|
      builder.response :logger
      builder.request :authorization, :basic,
                      Rails.application.credentials.slack.client_id,
                      Rails.application.credentials.slack.client_secret
    end

    response = connection.post('/api/oauth.v2.access') do |req|
      req.params['code'] = params[:code]
    end

    auth_data = JSON.parse(response.body).with_indifferent_access

    return render(json: auth_data) unless auth_data[:ok]

    @organization = Authorization.find_by(platform: 'Slack', uid: auth_data.dig(:team, :id))&.organization
    if @organization.blank?
      ActiveRecord::Base.transaction do
        @organization = Organization.create!(name: auth_data.dig(:team, :name))
        @organization.authorizations.create!(
          platform: 'Slack',
          uid: auth_data.dig(:team, :id),
          access_token: auth_data[:access_token],
          refresh_token: auth_data[:refresh_token],
          expires_at: auth_data[:expires_in].seconds.from_now
        )
      end
    end
    session[:organization_id] = @organization.id
    redirect_to organization_path
  end
end
