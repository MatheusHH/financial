class Source < ApplicationRecord
  belongs_to :user
  has_many :incomes

  validates :name, presence: true
end
