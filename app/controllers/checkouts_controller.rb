class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show, :scan]

  def create
    @checkout = Checkout.create!(checkout_params)
    json_response(@checkout.id, :created)
  end

  def scan
    upc = params[:upc]
    add_checkout_item(upc)
    json_response(scan_response_with_item_details(upc))
  end

  def checkout_total
    json_response({id: @checkout.id, 100.00, 10.00, [], 5.25})
  end

  private

  def scan_response_with_item_details(upc)
    item = Item.find_by(upc: upc)
    { upc: upc, description: item.description, price: item.price, is_exempt: item.is_exempt }
  end

  def add_checkout_item(upc)
    checkout_item = CheckoutItem.new(:upc => upc)
    @checkout.checkout_items << checkout_item
    checkout_item.save!
  end

  def checkout_params
    params.permit()
  end

  def set_checkout
    @checkout = Checkout.find(params[:id])
  end
end
