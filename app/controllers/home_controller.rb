class HomeController < ApplicationController
  def index
    if logged_in?
      @messages = current_user.messages_received
      @notifications = current_user.notifications
      @unread_messages_count ||= unread_message @notifications
    end
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
end
