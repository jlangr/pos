class Checkout < ApplicationRecord
  has_many :checkout_items, dependent: :destroy
end
