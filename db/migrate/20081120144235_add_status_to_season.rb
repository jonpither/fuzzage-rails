class AddStatusToSeason < ActiveRecord::Migration
  def self.up
      add_column :seasons, :status, :string, :default => 'open'
  end

  def self.down
  end
end
