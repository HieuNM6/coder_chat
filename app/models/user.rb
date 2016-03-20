class User < ActiveRecord::Base
  has_many :messages
  has_many :messages_received, class_name: 'Message', foreign_key: :to_id
  has_many :notifications

  has_secure_password
  validates :name, length: {minimum: 5}
  validates :email, uniqueness: true

  def init
    self.friend_list ||= ""
  end

  def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    user.name = user.email.split("@").first
    user.password = "Pa55W@rd"
    user.password_confirmation = "Pa55W@rd"
    #
    # Set other properties on user here.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally, return user
    user.save && user
  end 
end
