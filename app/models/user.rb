require "digest/sha1"

class User < ActiveRecord::Base
    attr_accessor :password, :confirm_password

    validates_presence_of :name, :email
    validates_length_of :name, :maximum => 100,  :allow_blank => true
    validates_length_of :name, :minimum => 2,  :allow_blank => true

    def validate_on_create
        @email_format = Regexp.new(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/)
        errors.add(:email, "must be a valid format") unless email == nil || email.length < 1 || @email_format.match(email)
        errors.add(:confirm_password, "does not match") unless password == confirm_password
        errors.add(:password, "can't be blank") if !password or password.length < 1
    end

    # hash password before create
    def before_create
        self.hashed_password = User.hash_password(self.password)
    end

    # after creation, clear password from memory
    def after_create
      @password = nil
      @confirm_password = nil
    end

    private

    # hash password for storage in database
    def self.hash_password(password)
        Digest::SHA1.hexdigest(password)
    end

end
