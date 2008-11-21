class Team < ActiveRecord::Base
    belongs_to :user
    belongs_to :season

    validates_presence_of :name
    validates_length_of :name, :within => 4..50
end
