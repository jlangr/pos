class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show, :scan, :checkout_total]

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
    # verify checkout id
    
    messages = []

    total_of_discounted_items = 0
    total = 0
    total_saved = 0

    @checkout.checkout_items.each do | checkout_item |
      item = Item.find_by(checkout_item.upc)
      price = item.price
      is_exempt = item.is_exempt
      if is_exempt

      else
        total += price
        text = item.description
        amount = sprintf("%.2f", price.round(2))
        amount_width = amount.length
        
        text_width = LINE_WIDTH - amount_width
        messages << text + amount
      end
    end

    json_response({id: @checkout.id, total: total, total_of_discounted_items: total_of_discounted_items, messages: messages, total_saved: total_saved})
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
