class AddItemToAttachements < ActiveRecord::Migration
  def self.up
    add_attachment :attachments, :item
  end

  def self.down
    remove_attachment :attachments, :item
  end
end
