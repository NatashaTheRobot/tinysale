class AddCoverToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :cover
  end

  def self.down
    remove_attachment :images, :cover
  end
end
