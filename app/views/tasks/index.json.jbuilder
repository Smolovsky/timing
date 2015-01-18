json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :time_to_plan, :user_id
  json.url task_url(task, format: :json)
end
