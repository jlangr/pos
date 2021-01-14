class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|

      t.timestamps
    end
  end
end
