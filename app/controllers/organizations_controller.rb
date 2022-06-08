# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :find_organization

  def show; end

  def edit; end

  def update
    if @organization.update(params.require(:organization).permit(:name, :emoji, :daily_budget))
      redirect_to organization_path
    else
      render :edit
    end
  end

  private

  def find_organization
    @organization = Organization.find_by(id: session[:organization_id])
    redirect_to root_path, alert: 'Unauthenticated' if @organization.blank?
  end
end
