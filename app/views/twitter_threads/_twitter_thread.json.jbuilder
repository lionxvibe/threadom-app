json.extract! twitter_thread, :id, :scheduled_at, :created_at, :updated_at
json.url twitter_thread_url(twitter_thread, format: :json)
