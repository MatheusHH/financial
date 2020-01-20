json.extract! payment_card, :id, :invoice_payment_date, :value, :card_id, :account_id, :user_id, :created_at, :updated_at
json.url payment_card_url(payment_card, format: :json)
