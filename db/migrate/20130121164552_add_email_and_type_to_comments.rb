class AddEmailAndTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :email, :string
    add_column :comments, :subtype, :string
  end
end
