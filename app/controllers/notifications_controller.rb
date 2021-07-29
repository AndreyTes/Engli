class NotificationsController < ApplicationController
 
  def index
    @notifications = PublicActivity::Activity.order(created_at: "desc").where(recipient_id: current_user.id)
  end

  def read_all
    PublicActivity::Activity.where(recipient_id: current_user.id).update_all({readed: true})
    redirect_to notifications_path
  end
end
