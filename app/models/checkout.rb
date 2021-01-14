class Checkout < ApplicationRecord
  has_many :items, dependent: :destroy
end
