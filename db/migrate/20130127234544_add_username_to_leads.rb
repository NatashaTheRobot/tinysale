class AddUsernameToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :username, :string
  end
end
