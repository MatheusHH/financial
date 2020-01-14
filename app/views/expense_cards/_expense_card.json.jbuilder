json.extract! expense_card, :id, :invoice_date, :value, :status, :card_id, :user_id, :created_at, :updated_at
json.url expense_card_url(expense_card, format: :json)
