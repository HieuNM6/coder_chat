class Message < ActiveRecord::Base
  default_scope {order('created_at DESC')}
  attr_accessor :email

  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: :to_id
  has_one :notification, as: :event

  after_create :send_notification

  validates :content, presence: true
  validates :to_id, presence: true
  
  private
  def send_notification
    self.create_notification(user: self.recipient)
  end
end
