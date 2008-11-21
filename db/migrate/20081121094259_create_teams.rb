class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.column "name", :string
      t.column :user_id, :integer, :null => false
      t.column :season_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
