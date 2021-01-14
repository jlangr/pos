class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show]

  def create
    @checkout = Checkout.create!(checkout_params)
    json_response(@checkout.id, :created)
  end

  private

  def checkout_params
    params.permit()
  end

  def set_checkout
    @checkout = Checkout.find(params[:id])
  end
end
