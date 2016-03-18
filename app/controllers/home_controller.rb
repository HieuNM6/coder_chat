class HomeController < ApplicationController
  helper_method :recipient_of_message
  def index
    if logged_in?
      @messages = current_user.messages_received
      @notifications = current_user.notifications
      @unread_messages_count ||= unread_message @notifications
    end
  end

  def sent_messages
    @messages = current_user.messages
  end
  private
    def unread_message notifications
      counter = 0
      notifications.each do |n|
        unless n.read
         counter += 1  
        end
      end
      counter
    end

    def recipient_of_message message
      User.find_by_id(message.to_id)
    end
end
