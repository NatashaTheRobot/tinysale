class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :email
      t.string :token

      t.timestamps
    end
    add_index :leads, :email, unique: true
    add_index :leads, :token, unique: true
    add_column :comments, :lead_id, :integer
  end
end
