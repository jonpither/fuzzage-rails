class CreateRoles < ActiveRecord::Migration
    def self.up
        create_table :roles do |t|
            t.string :name, :null => false
        end

        create_table :users_roles do |t|
            t.column :user_id, :integer, :null => false
            t.column :role_id, :integer, :null => false
        end

        add_index :roles, :name
    end

    def self.down
        drop_table :roles
        drop_table :user_roles
    end
end
