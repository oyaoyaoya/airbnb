class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, default: 1
      t.references :room
      t.references :reservation
      t.references :guest
      t.references :host
      t.string :type

      t.timestamps

    end
    add_foreign_key :reviews, :rooms, column: :room_id
    add_foreign_key :reviews, :reservations, column: :reservation_id
    add_foreign_key :reviews, :users, column: :guest_id
    add_foreign_key :reviews, :users, column: :host_id
  end
end
