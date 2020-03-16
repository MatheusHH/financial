class Appointment < ApplicationRecord
  belongs_to :user

  enum status: [ :pendente, :feito ]

  validates :schedule, uniqueness: { scope: :user_id,
    message: "This schedule is already being used !" }
end
