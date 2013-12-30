json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :points, :complete, :completed_on, :course, :category
  json.url task_url(task, format: :json)
end
