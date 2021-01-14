class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :phone
      t.decimal :discount

      t.timestamps
    end
  end
end
