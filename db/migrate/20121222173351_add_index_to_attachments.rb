class AddIndexToAttachments < ActiveRecord::Migration
  def change
    add_index :attachments, :product_id
  end
end
