class User < ActiveRecord::Base
    attr_accessor :password, :confirm_password

    validates_presence_of :name, :email
    validates_length_of :name, :maximum => 100, :allow_nil => true
    validates_length_of :name, :minimum => 2,  :allow_nil => true

    def validate_on_create
        @email_format = Regexp.new(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/)
        errors.add(:email, "must be a valid format") unless email == nil || @email_format.match(email)
#        errors.add(:confirm_password, "does not match") unless password == confirm_password
#        errors.add(:password, "cannot be blank") unless !password or password.length > 0
    end
end
