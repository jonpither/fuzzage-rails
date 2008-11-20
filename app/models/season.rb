class Season < ActiveRecord::Base
    validates_presence_of :name     #
    validates_length_of :name, :within => 4..50

    def self.statuses
        ['open', 'closed']
    end
end
