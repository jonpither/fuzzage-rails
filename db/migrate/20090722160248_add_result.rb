class AddResult < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.timestamps
    end
  end

  def self.down
  end
end
