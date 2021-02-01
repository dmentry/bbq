Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))

Resque.logger.level = Logger::INFO

Resque.redis = Redis.new(password: Rails.application.credentials.dig(Rails.env.to_sym, :redis, :password))