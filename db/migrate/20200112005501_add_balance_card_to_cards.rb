class AddBalanceCardToCards < ActiveRecord::Migration[5.2]
  def change
    add_monetize :cards, :balance_card
  end
end
