class MessagesController < ApplicationController
  before_action :require_login 
  def new
    @message = current_user.messages.new
    unless params[:recipient_id].blank?
      @recipient = User.find_by_id(params[:recipient_id]) 
    end
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

  def show
    @message = Message.find_by_id(params[:id])
    unless @message.notification.read
      @message.notification.read = true
      @message.notification.save
    end
  end

  private
    def message_params
      params.require(:message).permit(:to_id, :content)
    end
end
