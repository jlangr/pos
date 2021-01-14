class Item < ApplicationRecord
  def to_str
    "#{description} @ #{price} [#{upc}]"
  end
end
