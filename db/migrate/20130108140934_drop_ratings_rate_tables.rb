class DropRatingsRateTables < ActiveRecord::Migration
  def change
    drop_table :ratings
    drop_table :rates
  end
end
