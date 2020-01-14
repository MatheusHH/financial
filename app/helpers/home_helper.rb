module HomeHelper
  def divide_by_100(value)
  	if value > 0 
  	  divided_value = value / 100
  	  divided_value
  	else
  	  divided_value = 0
  	end
  end

  def percent_card(balance, limit)
  	percent = (balance * 100) / limit
  	percent = percent.round(half: :up)
    percent 
  end
end
