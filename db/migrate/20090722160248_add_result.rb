class AddResult < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.column :home_score, :integer
      t.column :away_score, :integer
      t.column :home_team_id, :integer, :null => false
      t.column :away_team_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
  end
end
