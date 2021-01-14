class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.decimal :member_discount
      t.string :member_name

      t.timestamps
    end
  end
end
