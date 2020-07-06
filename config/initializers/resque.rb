REDIS_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/redis.yml")).result)[Rails.env]
Resque.redis = Redis.new(REDIS_CONFIG)

# dynamically change the schedule
#Resque::Scheduler.dynamic = true

#Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }