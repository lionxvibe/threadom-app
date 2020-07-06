json.extract! user, :id, :timezone, :is_locked, :is_admin, :created_at, :updated_at
json.url profile_path(user, format: :json)
