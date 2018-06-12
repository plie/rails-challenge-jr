class MessagesController < ApplicationController
  before_action :get_message, only: [:new]

  def new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "Thank you, your message has been saved. It's token is #{@message.token}."
      p "Here is your token: #{@message.token}"
      redirect_to messages_path
    else
      flash[:danger] = 'Need to create a valid password. Message not saved. Please try again.'
      redirect_to messages_path
    end
  end

  def show
    @message = Message.where(token: params[:token]).first
    p "Here is your message: #{params[:token]}"
    if @message && @message.password == params[:password]
      flash[:danger] = 'This message is deleted automatically. Once you leave this page this message will no longer be available.'
      redirect_to display_path
      @message.destroy  # destroy message when viewed and only when viewed
    else
      flash[:danger] = 'Incorrect password'
    end
  end

  private

  def get_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:token, :password, :message_body)
  end
end
