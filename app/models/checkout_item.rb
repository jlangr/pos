class CheckoutItem < ApplicationRecord
  belongs_to :checkout

  def to_str
    "CheckoutItem>> #{self.attributes}"
  end
end
