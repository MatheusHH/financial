module CardsHelper
  def sum_invoice(expenses)
  	sum = 0
  	expenses.each do |expense|
  	  sum += expense.value
  	end
  	sum
  end
end
