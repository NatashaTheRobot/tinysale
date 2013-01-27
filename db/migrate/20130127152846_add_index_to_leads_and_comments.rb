class AddIndexToLeadsAndComments < ActiveRecord::Migration
  def change
    add_index :comments, :lead_id
  end
end
