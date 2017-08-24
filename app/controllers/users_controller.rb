class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @rooms = @user.rooms

    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)
    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
  end

  def create
    if current_user.update(set_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
  end

  def dashboard
    @rooms = current_user.rooms
    current_user.unread = 0
    current_user.save
    @notifications = current_user.notifications.reverse
  end

  def reviews_about_you
    @guest_reviews = Review.where(type: "GuestReview", host_id: current_user.id)
    @host_reviews = Review.where(type: "HostReview", guest_id: current_user.id)
  end

  def set_params
    params.require(:user).permit(:image)
  end
end
