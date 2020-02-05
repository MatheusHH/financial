class DueCardNotificationJob < ApplicationJob
  queue_as :emails

  def perform(*args)
    users = User.where(role: :customer)
    current_date = Date.current
    users.each do |user|
      user_cards = user.cards
      user_cards.each do |card|
      	card_date = (current_date.beginning_of_month + card.invoice_day.days) - 1.day
      	if current_date == card_date
      	  DueCardMailer.notify(card.user, card).deliver_now
      	end 
      end
    end
  end
end
