class PagesController < ApplicationController
  def home
    @rooms = Room.where(active: true).limit(3)
  end

  def search
    search_params = params[:search]
    if search_params.blank?
      @rooms_address = Room.where(active: true).all
    else
      @rooms_address = Room.near_by_empty(search_params)
    end

    @search = @rooms_address.ransack(params[:q])
    @rooms = @search.result
    @arrRooms = @rooms.to_a

    unless params[:start_date].blank? && params[:end_date].blank?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @rooms.each do |room|

        not_available = room.reservations.where(
          "((? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date))
          AND status = ?",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date,
          1
        ).limit(1)

        if not_available.length > 0
          @arrRooms.delete(room)
        end
      end
    end
  end
end
