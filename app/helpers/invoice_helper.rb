module InvoiceHelper
  def sum_invoice(expenses)
  	sum = 0
  	unless expenses.nil?
  	  expenses.each do |expense|
  	    sum += expense.value
  	  end
  	end
  	sum
  end
end
