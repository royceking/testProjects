require "./house_obj.rb"
require "awesome_print"
 
intitial_money = 20000
 
house1 = House.new(155000, 10000, 830, 0.04, 120, 30, 1)

years = (1..30).to_a
 
# puts "Monthly Loan Payment = $#{house1.monthly_payment}"
# puts "Monthly Insurance = $#{house1.monthly_insurance}"
# puts "Monthly Taxes = $#{house1.monthly_taxes}"
# puts "Monthly MIP = $#{house1.monthly_mip}"
# puts "Monthly Cost = $#{house1.monthly_cost}"
# puts "Proposed monly rent rate = $#{house1.rental_rate}"
# puts "Total paid to lender = $#{house1.total_loan_amount}"
# puts "Total interest paid to lender = $#{house1.total_loan_interest}"
# puts "$#{house1.total_loan_paid(180)}"
# puts "$#{house1.total_loan_owed(180)}"

homes = {}

years.each do |year|
	house_price = (150000 + rand(100000))
	taxes = (house_price * 0.006).round(2)
	insurance = 130
	downpayment = 10000
	term = 30

	homes["house#{year}_1"] = House.new(house_price, downpayment, taxes, 0.04, insurance, term, year)
	#house = House.new(house_price, downpayment, taxes, 0.04, insurance, term)

	#homes["house#{year}_2"] = House.new((150000 + rand(100000), downpayment, (house_price * 0.006).round(2), 0.04, insurance, term, year) if year < 10
	# puts "******************************************"
	# puts "House #{year}"
	# puts
	# puts "House Price = $#{house.price}"
	# puts "House downpayment = $#{house.downpayment}"
	# puts "Monthly Loan Payment = $#{house.monthly_payment}"
	# puts "Monthly Insurance = $#{house.monthly_insurance}"
	# puts "Monthly Taxes = $#{house.monthly_taxes}"
	# puts "Monthly MIP = $#{house.monthly_mip}"
	# puts "Monthly Cost = $#{house.monthly_cost}"
	# puts "Proposed monly rent rate = $#{house.rental_rate}"
	# puts "Total paid to lender = $#{house.total_loan_amount}"
	# puts "Total interest paid to lender = $#{house.total_loan_interest}"
	# puts "******************************************"
	# puts
end

# years.each do |year|
# 	puts year.to_s
# 	ap house1.stats["year_#{year}"]
# end

# puts "Monthly Loan Payment = $#{house1.monthly_payment}"
# puts "Monthly Insurance = $#{house1.monthly_insurance}"
# puts "Monthly Taxes = $#{house1.monthly_taxes}"
# puts "Monthly MIP = $#{house1.monthly_mip}"
# puts "Monthly Cost = $#{house1.monthly_cost}"
# puts "Proposed monly rent rate = $#{house1.rental_rate}"
# puts "Total paid to lender = $#{house1.total_loan_amount}"
# puts "Total interest paid to lender = $#{house1.total_loan_interest}"


years.each do |year|
	profit = 0
	principal = 0
	debt = 0
	count = 0
	years.each do |year2|
		if year2 <= year 
			count += 1
			principal = principal + homes["house#{year}_1"].stats["year_#{year}"][:principal]
			debt = debt + homes["house#{year}_1"].stats["year_#{year}"][:balance]
			profit = profit + homes["house#{year}_1"].stats["year_#{year}"][:profit]
		end
	end

	puts "In year #{year}, house count = #{count}, Equity = $#{principal.round(2)}, Total debt = $#{debt.round(2)}, Rental profit = $#{profit.round(2)}"
end



