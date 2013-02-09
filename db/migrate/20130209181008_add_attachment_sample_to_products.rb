class AddAttachmentSampleToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :sample
    end
  end

  def self.down
    drop_attached_file :products, :sample
  end
end
