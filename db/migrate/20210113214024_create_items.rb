class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :upc
      t.decimal :price
      t.string :description
      t.boolean :is_exempt

      t.timestamps
    end
  end
end
