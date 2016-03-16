class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: :to_id
  has_many :notifications, as: :event

  after_create :send_notification
  
  private
  def send_notification
    self.notifications.create(user: self.recipient)
  end
end