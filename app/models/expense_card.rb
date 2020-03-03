class ExpenseCard < ApplicationRecord
  belongs_to :card
  belongs_to :user

  enum status: [ :pendente, :pago ]

  monetize :value_cents

  before_create :update_limit_card_create
  before_update :update_limit_card_update
  before_destroy :update_limit_card_deteted
  after_commit :expense_times_create, on: :create

  before_validation :set_status, on: :create

  validates :invoice_date, presence: true
  validates :card_id, presence: true

  private

  def update_limit_card_create
  	if self.card_id.present?
  	  card = Card.find(self.card_id) #verificar antes total expense
      total_value = self.value_cents * (self.expense_times.to_i + 1)
  	  if card.balance_card_cents >= self.value_cents && card.balance_card_cents >= total_value
  	  	card.balance_card_cents -= self.value_cents
  	  	card.update(balance_card_cents: card.balance_card_cents)
  	  else
  	  	self.errors.add :base, "There is not limit available" 
  	  	raise ActiveRecord::RecordInvalid.new(self)
  	  end
  	end
  end

  def expense_times_create
    if self.expense_times.to_i > 0
      card = Card.find(self.card_id)
      total_value = self.value_cents * self.expense_times.to_i
      if self.expense_times.to_i > 0 && card.balance_card_cents >= total_value
        date = Date.current
        (1..self.expense_times.to_i).each { 
          date = date + 30.days
          ExpenseCard.create(invoice_date: date, value: self.value, card_id: self.card_id, user_id: self.user_id)
        }
      else
        self.errors.add :base, "There is not limit available" 
        raise ActiveRecord::RecordInvalid.new(self)
      end
    end
  end 
 
  def update_limit_card_update
    if self.card_id.present?
      card = Card.find(self.card_id)
      if self.value_cents_changed? && self.pendente?
        card.balance_card_cents += self.value_cents_was
        if card.balance_card_cents >= self.value_cents_change[1]
          card.balance_card_cents -= self.value_cents_change[1]
          card.update(balance_card_cents: card.balance_card_cents)
        else
          self.errors.add :base, "There is not balance available" 
          raise ActiveRecord::RecordInvalid.new(self)
        end
      elsif self.invoice_date_changed? && self.pago?
        self.errors.add :base, "There expense is paid, you need to remove payment to open it" 
        raise ActiveRecord::RecordInvalid.new(self)
      elsif self.value_cents_changed? && self.pago?
        self.errors.add :base, "There expense is paid, you need to remove payment to open it" 
        raise ActiveRecord::RecordInvalid.new(self)
      end
    end
  end

  def update_limit_card_deteted
    if self.pendente?
      card = Card.find(self.card_id)
      value_to_be_restored = self.value_cents
      card.balance_card_cents += value_to_be_restored
      card.update(balance_card_cents: card.balance_card_cents)
    else
      self.errors.add :base, "You need to remove the payment before delete this expense" 
      raise ActiveRecord::RecordInvalid.new(self)
    end 
  end

  def set_status
    self.status = "pendente"
  end
end
