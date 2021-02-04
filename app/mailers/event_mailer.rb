class EventMailer < ApplicationMailer
  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    mail(to: @event.user.email, subject: t('.subject', title: @event.title))
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail(to: email, subject: t('.subject', title: @event.title))
  end

  def photo(photo, email)
    @event = photo.event
    @photo = photo

    mail(to: email, subject: t('.subject', title: @event.title))
  end
end
