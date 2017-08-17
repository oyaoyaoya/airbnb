class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, alert: "You don't have permission to view this."
    end
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
