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

  def set_params
    params.require(:user).permit(:image)
  end
end
