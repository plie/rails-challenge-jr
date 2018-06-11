class MessagesController < ApplicationController
  before_action :get_message, only: [:new, :unlock]

  def new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      Rails.logger.info("Message token: #{@message.token}")
      flash[:notice] = "Thank you, your message has been saved. It's token is #{@message.token}."
    else
      flash[:error] = 'Need to create a valid password. Message not saved. Please try again.'
    end
  end

  def unlock
  end

  def show
    @message = Message.find(:token)
    if @message && @message.password == params[:password]
      redirect_to display_path
    else
      flash[:error] = 'Incorrect password'
      redirect_to unlock_path
    end
    @message.destroy
  end

  private

  def get_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:password, :token, :message_body)
  end
end
