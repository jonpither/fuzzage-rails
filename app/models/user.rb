require "digest/sha1"

class User < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => 'users_roles'
  has_many :teams

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

  def try_to_login
    User.login(self.email, self.password)
  end

  def has_role?(role)
    self.roles.each { | user_role |
      if (role==user_role.name)
        return true
      end
    }
    return false;
  end

  def add_role(role)
    return if self.has_role?(role)
    self.roles << Role.find_by_name(role)
  end

  def playing_in? season
    teams.each { |user_team| return true if season.has_team?(user_team)}
    false
  end

  private

  def self.login(email, password)
    hashed_password = hash_password(password || '')
    find(:first,
         :conditions => ["email = ? and hashed_password = ? and email_confirmed = true", email, hashed_password])
  end

  # hash password for storage in database
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end

end
