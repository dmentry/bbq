class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(Rails.env.to_sym, :mailjet, :mailjet_sender)
  # default from: 'ex@example.com'
  layout 'mailer'
end
