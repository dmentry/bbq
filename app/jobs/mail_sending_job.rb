class MailSendingJob < ApplicationJob
  queue_as :default
    def perform(**arguments)
      local_event = nil

      if arguments[:comment]
        local_event = arguments[:comment].event
      elsif arguments[:photo]
        local_event = arguments[:photo].event
      end

      # собираю всех подписчиков и автора события в массив мэйлов, исключаю повторяющиеся
      all_emails = (local_event.subscriptions.map(&:user_email) + [local_event.user.email]).uniq if local_event

      if arguments[:subscription]
        EventMailer.subscription(arguments[:subscription]).deliver_later

      elsif arguments[:comment]
        #исключаю автора коммента, если он не аноним
        unless arguments[:comment].user == nil
          all_emails = all_emails - [(arguments[:comment].user.email)]
        end

        all_emails.each do |mail|
          EventMailer.comment(arguments[:comment], mail).deliver_later
        end

      elsif arguments[:photo]
        # собираем всех подписчиков, кроме автора фотки в массив мэйлов, исключаем повторяющиеся
        all_emails = all_emails - [arguments[:photo].user.email]

        all_emails.each do |mail|
          EventMailer.photo(arguments[:photo], mail).deliver_later
        end
      end
  end
end
