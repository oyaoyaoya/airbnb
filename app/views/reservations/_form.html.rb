<%= form_for([@room, @room.reservations.new]) do |f| %>
  <%= f.text_field :start_date %>
  <%= f.text_field :end_date %>
  <%= f.hidden_field :room_id, value: @room.id %>
  <%= f.hidden_field :price, value: @room.price %>

  <br>
  <%= f.submit "Book Now", class: "btn btn-primary" %>
<% end %>

<script>
$(function() {
  $('#reservation_start_date').datepicker({
    dateFormat: 'dd-mm-yy'
    })
  $('#reservation_end_date').datepicker({
    dateFormat: 'dd-mm-yy'
    })
  })
</script>
