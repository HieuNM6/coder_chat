class User < ActiveRecord::Base
  has_many :messages
  has_many :messages_received, class_name: 'Message', foreign_key: :to_id
  has_many :notifications

  has_secure_password
  validates :name, length: {minimum: 5}
end
