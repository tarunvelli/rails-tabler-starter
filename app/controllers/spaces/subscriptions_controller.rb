# frozen_string_literal: true

class Spaces::SubscriptionsController < ApplicationController
  before_action :set_space, only: %i[index new create]
  before_action :set_plan, only: %i[new]
  before_action :set_active_subscription, only: %i[index]

  # GET /spaces/:space_id/subscriptions or /spaces/:space_id/subscriptions.json
  def index; end

  # GET /spaces/:space_id/subscriptions/new or /spaces/:space_id/subscriptions/new.json
  def new; end

  # POST /spaces/:space_id/subscriptions or /spaces/:space_id/subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save!
        format.html { redirect_to space_subscriptions_path(@space), notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_active_subscription
    @active_subscription = @space.active_subscription
  end

  def set_plan
    return unless params[:plan_id]

    @plan = Plan.find(params[:plan_id])
    @subscription = Subscription.new
  end

  def subscription_params
    params.require(:subscription).permit(:space_id, :plan_id, :start_date)
  end
end
