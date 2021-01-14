class Item < ApplicationRecord
  def to_str
    "#{description} @ #{price} [#{upc}]"
  end

  validates_presence_of :upc, :description, :price
end
