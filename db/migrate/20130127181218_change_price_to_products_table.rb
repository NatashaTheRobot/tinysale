class ChangePriceToProductsTable < ActiveRecord::Migration
  def change
    add_column :products, :price_in_cents, :integer
    remove_column :attachments, :price_in_cents
  end
end
