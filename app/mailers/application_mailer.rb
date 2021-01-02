class ApplicationMailer < ActionMailer::Base
  # default from: 'test@dack9.ru'
  default from: ENV["MAILJET_SENDER"]
  # default from: Rails.application.credentials.mailjet[:mailjet_sender]
  layout 'mailer'
end
