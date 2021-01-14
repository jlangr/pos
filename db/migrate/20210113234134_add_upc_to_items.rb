class AddUpcToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :upc, :string
  end
end
