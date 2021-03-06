class GroupsController < ApplicationController
  before_action :set_group, except: [:new, :create]

  def new
    @group = Group.new
    @users = []
    @users << current_user
    # @except_current_user = User.where.not(id: current_user.id )
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to :root, notice: "グループを作成しました"
    else
      @users = []
      @users << current_user
      render :new, alert: "グループ作成に失敗しました"
    end
  end

  def edit
    @users = @group.users
    # @except_current_user = User.where.not(id: current_user.id )
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end
  def set_group
    @group = Group.find(params[:id])
  end
end
