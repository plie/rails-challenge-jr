class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.password != '' && @message.save
      flash[:success] = "Your message has been saved."
      Rails.logger.info("Here is your token: #{@message.token}. Use this URL to retrieve: /token/password")
      redirect_to root_path
    else
      flash.now[:danger] = 'Message not saved. Need to create a valid password.'
      render action: "new"
    end
  end

  def show
    @message_temp = Message.find_by_token(params[:token])
    if @message_temp.password == params[:password]
      Rails.logger.info("Authentication succeeded")
      @message = @message_temp
      flash.now[:warning] = 'This message has been deleted. Once you leave this page this message will no longer be available.'
      @message.destroy
    else
      Rails.logger.info("Authentication failed")
      flash[:danger] = 'Please use a valid password and token.'
      redirect_to root_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:password, :message_body)
  end
end
