class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :product
      t.string :email

      t.timestamps
    end
    add_index :transactions, :product_id
    add_index :transactions, :email
  end
end
