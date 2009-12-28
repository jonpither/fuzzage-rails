class AddScore < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.column :score, :integer
      t.column :team_id, :integer, :null => false
      t.column :result_id, :integer, :null => false
      t.timestamps
    end    
  end

  def self.down
  end
end
