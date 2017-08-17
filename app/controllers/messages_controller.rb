class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def create
  end

  private
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:context, :user_id)
    end

end
