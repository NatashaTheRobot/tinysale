class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :status
      t.integer :price_in_cents
      t.references :product

      t.timestamps
    end
  end
end
