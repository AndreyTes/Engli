class UsersController < ApplicationController
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by(id: params[:id]) 
    @phrases = @user.phrases
  end  
end
