class ApplicationMailer < ActionMailer::Base
  # default from: 'test@dack9.ru'
  default from: ENV["MAILJET_SENDER"]
  layout 'mailer'
end
