json.extract! expense, :id, :duedate, :category_id, :supplier_id, :status, :value, :user_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
