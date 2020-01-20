class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :admin, :customer ]

  has_many :suppliers, dependent: :destroy
  has_many :caategories, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :expense_cards, dependent: :destroy
  has_many :payment_cards, dependent: :destroy
  
end
