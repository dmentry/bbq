class MailSendingJob < ApplicationJob
  queue_as :default
    def perform(arguments)
    if arguments[:subscription]
      EventMailer.subscription(arguments[:event], arguments[:subscription]).deliver_later

    elsif arguments[:comment]
      # собираю всех подписчиков и автора события в массив мэйлов, исключаю повторяющиеся
      all_emails = (arguments[:event].subscriptions.map(&:user_email) + [arguments[:event].user.email]).uniq

      #исключаю автора коммента, если он не аноним
      unless arguments[:comment].user == nil
        all_emails - [(arguments[:comment].user.email)]
      end

      all_emails.each do |mail|
        EventMailer.comment(arguments[:event], arguments[:comment], mail).deliver_later
      end

    elsif arguments[:photo]
      # собираем всех подписчиков, кроме автора фотки в массив мэйлов, исключаем повторяющиеся
      all_emails = (arguments[:event].subscriptions.map(&:user_email) + [arguments[:event].user.email]).uniq - [arguments[:photo].user.email]

      all_emails.each do |mail|
        EventMailer.photo(arguments[:event], arguments[:photo], mail).deliver_later
      end
    end
  end
end
