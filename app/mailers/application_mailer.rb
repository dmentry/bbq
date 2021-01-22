class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials[Rails.env.to_sym][:mailjet][:mailjet_sender]
  layout 'mailer'
end
