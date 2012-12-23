class AddIndexToPermalinkInProducts < ActiveRecord::Migration
  def change
    add_index :products, :permalink, unique: true
  end
end
