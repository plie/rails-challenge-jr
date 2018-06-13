class MessagesController < ApplicationController
  before_action :get_message, only: [:new]

  def new
  end

  def create
    @message = Message.new(message_params)
    if @message.password != '' && @message.save
      flash[:success] = "Thank you, your message has been saved. Here is your URL: /#{@message.token}/YourPasswordHere."
      p "Here is your token: #{@message.token}"
      redirect_to messages_path
    else
      flash[:danger] = 'Message not saved. Need to create a valid password. Please try again.'
      redirect_to messages_path
    end
  end

  def show
    message = Message.find_by_token(params[:token])
    if message.password == params[:password]
      @message = message
      flash[:danger] = 'This message has been deleted. Once you leave this page this message will no longer be available.'
      @message.destroy
    else
      flash[:danger] = 'Please use a valid password and token, using this URL format: /token/password.'
    end
  end

  private

  def get_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:password, :message_body)
  end
end
