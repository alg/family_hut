class AddLocaleAndTimezoneToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :locale,     :string, :default => 'ru'
    add_column :users, :time_zone,  :string, :default => 'Kyiv'
  end

  def self.down
    remove_column :users, :time_zone
    remove_column :users, :locale
  end
end
