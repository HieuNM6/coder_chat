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

  def friends
    @friends = []
    unless friend_list.blank?
      friend_list.each do |f|
        @friends << User.find_by_id(f)
      end
    end 
  end

  def add_friend
    @users = User.all
    @friend_list = friend_list
    unless params[:add_friend].blank?
      @friend_list << params[:add_friend]
      current_user.update(friend_list: @friend_list.join(" "))
      flash[:success] = "Add friend successful"
      redirect_to friends_path
    end
    unless params[:remove_friend].blank?
      @friend_list.delete(params[:remove_friend])
      current_user.update(friend_list: @friend_list.join(" "))
      flash[:success] = "Remove friend successful"
      redirect_to friends_path
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

    def recipient_of_message message
      User.find_by_id(message.to_id)
    end

    def friend_list
      friend_list = []
      list ||= current_user.friend_list.split(" ")
      list.each do |l|
        friend_list << l
      end
      friend_list
    end
end
