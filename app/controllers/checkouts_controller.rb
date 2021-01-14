
class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show, :scan, :checkout_total, :scan_member]
  LINE_WIDTH=45

  def show
    json_response(@checkout)
  end

  def create
    @checkout = Checkout.create!(checkout_params)
    json_response({ id: @checkout.id }, :created)
  end

  def scan
    upc = params[:upc]
    add_checkout_item(upc)
    json_response(scan_response_with_item_details(upc))
  end

  def scan_member
    member = Member.find_by(phone: params[:member_phone])
    @checkout.member_name = member.name
    @checkout.member_discount = member.discount
    @checkout.save!
  end

  def checkout_total
    # verify checkout id
    
    messages = []
    discount = @checkout.member_name ? @checkout.member_discount : 0

    total_of_discounted_items = 0
    total = 0
    total_saved = 0

    @checkout.checkout_items.each do | checkout_item |
      item = Item.find_by(checkout_item.upc)
      price = item.price
      is_exempt = item.is_exempt
      if not is_exempt and discount > 0
        discount_amount = discount * price
        discounted_price = price * (1.0 - discount)

        total_of_discounted_items += discounted_price # add into total

        text = item.description
        # format percent
        amount = sprintf("%.2f", price.round(2))
        amount_width = amount.length

        text_width = LINE_WIDTH - amount_width
        messages << text.ljust(text_width) + amount

        total += discounted_price

        # discount line
        discount_formatted = '-' + sprintf("%.2f", discount_amount.round(2))
        text_width = LINE_WIDTH - discount_formatted.length
        text = "   #{discount * 100}% mbr disc"
        messages << "#{text.ljust(text_width)}#{discount_formatted}"

        total_saved += discount_amount
      else
        total += price
        text = item.description
        amount = sprintf("%.2f", price.round(2))
        amount_width = amount.length
        
        text_width = LINE_WIDTH - amount_width
        messages << text.ljust(text_width) + amount
      end
    end

    # append total line
    formatted_total = sprintf("%.2f", total.round(2))
    formatted_total_width = formatted_total.length
    text_width = LINE_WIDTH - formatted_total_width
    messages << "TOTAL".ljust(text_width) + formatted_total

    if total_saved > 0
      formatted_total = sprintf("%.2f", total_saved.round(2))
      puts("formatted_total: #{formatted_total}")
      formatted_total_width = formatted_total.length
      text_width = LINE_WIDTH - formatted_total_width
      messages << "*** You saved:".ljust(text_width) + formatted_total
    end

    total_of_discounted_items = sprintf("%.2f", total_of_discounted_items.round(2))
    total_saved = sprintf("%.2f", total_saved.round(2))

    # send total saved instead
    json_response({checkout_id: @checkout.id, total: total, total_of_discounted_items: total_of_discounted_items, messages: messages, total_saved: total_saved})
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
