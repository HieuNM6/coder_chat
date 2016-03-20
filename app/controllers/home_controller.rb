class HomeController < ApplicationController
  def index
    if logged_in?
      @messages = current_user.messages_received
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

  def user_list
    @users = User.all
    @friend_list = friend_list
    @block_list = block_list
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
    unless params[:block].blank?
      @block_list << params[:block]
      current_user.update(block_list: @block_list.join(" "))
      flash[:success] = "Block successful"
      redirect_to user_list_path
    end
    unless params[:unblock].blank?
      @block_list.delete(params[:unblock])
      current_user.update(block_list: @block_list.join(" "))
      flash[:success] = "Unblock successful"
      redirect_to user_list_path
    end
  end

  private
    def friend_list
      friend_list = []
      list ||= current_user.friend_list.split(" ")
      list.each do |l|
        friend_list << l
      end
      friend_list
    end

    def block_list
      block_list = []
      list ||= current_user.block_list.split(" ")
      list.each do |l|
        block_list << l
      end
      block_list
    end

end
