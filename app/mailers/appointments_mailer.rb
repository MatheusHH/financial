class AppointmentsMailer < ApplicationMailer
  default from: 'notifications@myfinancials.com'

  def advise(results, user)
    @appointments = results
    @user = user 

    mail(to: @user.email, subject: 'Appointments Today')
  end
end
