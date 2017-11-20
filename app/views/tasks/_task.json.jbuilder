json.extract! task, :id, :task, :details, :created_at, :updated_at, :user_id, :status, :due_date, :attachments
json.url task_url(task, format: :json)