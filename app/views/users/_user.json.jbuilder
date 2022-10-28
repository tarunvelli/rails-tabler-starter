json.extract! user, :id, :name, :phone, :email, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
