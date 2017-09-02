class PagesController < ApplicationController
  def home
    @rooms = Room.where(active: true).limit(3)
  end

  def search
    name, start_date, end_date = params[:search], params[:start_date], params[:end_date]

    @rooms_address = Room.search_from_location(name)
    @search = @rooms_address.ransack(params[:q])
    @rooms = @search.result
    @arrRooms = @rooms.to_a
    unless start_date.blank? && end_date.blank?
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
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
        # 今やっている事
        # 1, 23 ~ 32行をActiverecordのエリインターフェースを使って記述
        # https://railsguides.jp/active_record_querying.html#or%E6%9D%A1%E4%BB%B6
        #  - 現状： SQLに近い記述
        #  - ゴール： ActiveRecordのクエリインターフェースを使って記述（Railsのレールに乗る）
        # 　　　　　　例：where / not / or メソッド当たり
        #      メリット: SQLはDBに依存しているため互換性が少なくなる
        #               (mysqlや、SQLiteの方言を使うと通じない)
        # 2, ドモルガンの法則で最適化できるかな?(個人的に楽しそう)
      end
    end
  end
end
