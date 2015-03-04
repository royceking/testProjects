 require "./house_obj.rb"
 require 'ap'
 
intitial_money = 20000
 
# house1 = House.new(230000, 10000, 1380, 0.04, 120, 30)

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
	taxes = (house_price * 0.006).round
	insurance = 130
	downpayment = 10000
	term = 30

	homes["house#{year}"] = House.new(house_price, downpayment, taxes, 0.04, insurance, term)
	house = House.new(house_price, downpayment, taxes, 0.04, insurance, term)
	puts "******************************************"
	puts "House #{year}"
	puts
	puts "House Price = $#{house.price}"
	puts "House downpayment = $#{house.downpayment}"
	puts "Monthly Loan Payment = $#{house.monthly_payment}"
	puts "Monthly Insurance = $#{house.monthly_insurance}"
	puts "Monthly Taxes = $#{house.monthly_taxes}"
	puts "Monthly MIP = $#{house.monthly_mip}"
	puts "Monthly Cost = $#{house.monthly_cost}"
	puts "Proposed monly rent rate = $#{house.rental_rate}"
	puts "Total paid to lender = $#{house.total_loan_amount}"
	puts "Total interest paid to lender = $#{house.total_loan_interest}"
	puts "******************************************"
	puts
end
