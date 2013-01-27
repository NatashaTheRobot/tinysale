class ChangeUserDefaultsInComments < ActiveRecord::Migration
  def self.up
    execute "alter table comments " +
                "alter column user_id drop not null;"
    execute "alter table comments " +
                "alter column user_id drop default;"
  end

  def self.down
    execute "alter table comments " +
                "alter column user_id set not null;"
    execute "alter table comments " +
                "alter column user_id set default 0;"
  end
end
