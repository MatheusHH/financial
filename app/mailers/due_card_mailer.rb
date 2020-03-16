class DueCardMailer < ApplicationMailer
  default from: 'notifications@myfinancials.com'
 
  def notify(user, card)
    @user = user
    @user_name = user.name
    @card_name = card.card_name
    mail(to: @user.email, subject: 'Invoice Due')
  end
end
