class NotificationsController < ApplicationController
 
  def index
    @notifications =  current_user.public_activities.order(created_at: "desc")
  end

  def read_all
    current_user.public_activities.update_all(readed: true)
    redirect_to notifications_path
  end
end
