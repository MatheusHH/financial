json.extract! transfer, :id, :sender_account, :receiver_account, :value, :user_id, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
