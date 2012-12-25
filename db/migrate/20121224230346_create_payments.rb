class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :access_token
      t.string :publishable_key
      t.references :user

      t.timestamps
    end
    add_index :payments, :user_id
  end
end
