class MessagesController < ApplicationController
  before_action :require_login 
  helper_method :has_read?
  def new
    @message = current_user.messages.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      flash[:success] = "Your message has been sent"
      redirect_to root_path
    else
      flash[:error] = "Your message hasn't been sent"
      render 'new'
    end
  end

  def index
    @messages = current_user.messages_received
  end

  private
    def message_params
      params.require(:message).permit(:to_id, :content)
    end

    def has_read? message
      message.notifications.collect(&:read).first
    end
end
