json.array!(@session_of_timers) do |session_of_timer|
  json.extract! session_of_timer, :id, :date, :day_id, :time_in_work
  json.url session_of_timer_url(session_of_timer, format: :json)
end
