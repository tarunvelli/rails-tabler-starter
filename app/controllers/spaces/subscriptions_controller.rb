# frozen_string_literal: true

class Spaces::SubscriptionsController < ApplicationController
  before_action :set_space, only: %i[index]
  before_action :set_active_subscription, only: %i[index]

  # GET /spaces/:space_id/subscriptions or /spaces/:space_id/subscriptions.json
  def index; end

  private

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_active_subscription
    @active_subscription = @space.active_subscription
  end
end
