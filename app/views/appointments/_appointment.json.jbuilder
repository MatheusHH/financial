json.extract! appointment, :id, :schedule, :description, :status, :user_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
