class CreateCheckoutItems < ActiveRecord::Migration[6.1]
  def change
    create_table :checkout_items do |t|
      t.string :upc
      t.references :checkout, foreign_key: true

      t.timestamps
    end
  end
end
