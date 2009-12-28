class AddAdmin < ActiveRecord::Migration
    def self.up
        # Create admin:
        Role.create(:name => 'admin')

        admin = User.new({:email=>'admin@admin.com', :name=>'Administrator', :password=>'admin', :confirm_password=>'admin', :email_confirmed=>true})
        admin.add_role('admin')
        admin.save!
    end

    def self.down
    end
end
