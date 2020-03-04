class Appointment < ApplicationRecord
  belongs_to :user

  enum status: [ :pendente, :feito ]
end
