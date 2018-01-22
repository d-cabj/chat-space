class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @users = User.where('name LIKE(?)', "#{escape_like(user_search_params[:name])}%").order(created_at: "desc").limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
  def user_search_params
    params.permit(:name)
  end
  def escape_like(string)
    string.gsub(/[\\%_]/){|m| "\\#{m}"} if string
  end
end

