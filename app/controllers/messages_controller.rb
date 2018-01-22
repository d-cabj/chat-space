class MessagesController < ApplicationController
  before_action :set_group_and_messages, only: [:index, :create]

  def index
    @message = Message.new
    respond_to do |format|
      format.html
      format.json do
        @messages = Message.where("group_id = #{@group.id} AND id > #{params[:message_id]}").includes(:user)
      end
    end
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      @message.group.updated_at = Time.zone.now
      @message.group.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group), notice: "メッセージを投稿しました"}
        format.json
      end
    else
      redirect_to group_messages_path(@group)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :message_img).merge(user_id: current_user.id, group_id: @group.id)
  end

  def set_group_and_messages
    @group = Group.find(params[:group_id])
    @messages = @group.messages.includes(:user)
  end
end
