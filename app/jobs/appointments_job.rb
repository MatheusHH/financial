class AppointmentsJob < ApplicationJob
  queue_as :emails

  def perform(*args)
    users = User.where(role: :customer)
    current_date = Date.current
    users.each do |user|
      results = Appointment.where(user: user).where(status: :pendente).where('DATE(schedule) = ?', current_date)
      if results.size > 0
      	AppointmentsMailer.advise(results, user).deliver_now
      end 
    end
  end
end
