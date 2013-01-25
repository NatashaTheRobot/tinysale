class AddEmailAndTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :subtype, :string
  end
end
