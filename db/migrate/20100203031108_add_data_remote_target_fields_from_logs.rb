class AddDataRemoteTargetFieldsFromLogs < ActiveRecord::Migration
  def self.up
    add_column    :logs, :data, :text
    remove_column :logs, :target
  end

  def self.down
    add_column    :logs, :target, :string
    remove_column :logs, :data
  end
end
