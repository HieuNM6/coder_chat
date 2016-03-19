class MessagesController < ApplicationController
  before_action :require_login 
  def new
    @message = current_user.messages.new
    unless params[:recipient_email].blank?
      @recipient = User.find_by_email(params[:recipient_email]) 
    end
  end

  def create
    if email_params.blank?
      flash[:error] = "Email address can't blank"
      redirect_to new_message_path
      return
    end
    fails_send = []
    pass_send = []
    emails = email_params.split(";")
    emails.each_with_index do |email,index|
      user = User.find_by_email(email)
      if user.nil?
        fails_send<< email
        if (index+1) == emails.count
          has_sended_output(fails_send, pass_send)
          redirect_to new_message_path
        end
      else
        message = current_user.messages.new(to_id: user.id, content:content_params)
        if message.save
          pass_send << email
          if (index+1) == emails.count
            has_sended_output(fails_send, pass_send)
            redirect_to root_path
          end
        else
          fails_send << email
          if (index+1) == emails.count
            has_sended_output(fails_send, pass_send)
            render 'new'
          end
        end
      end
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
    def content_params
      params[:message][:content]
    end
    
    def email_params
      params[:message][:email]
    end
    
    def has_sended_output(fails, success)
      if fails.blank?
        flash[:success] = "Messages to address: '#{success.join(";")}' has been sent"
      elsif success.blank?
        flash[:error] = "Emails address: '#{fails.join(";")}' does not exist"
      else
        flash[:alert] = "Emails addess: '#{fails.join(";")}' does not exist,
        messages to address: '#{success.join(";")}' has been sent."
      end
    end
end
