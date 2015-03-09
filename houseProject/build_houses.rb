require "./house_obj.rb"
require "awesome_print"
require "thor"
 
class Rental < Thor 
	no_tasks do

		def initialize(*args)
			super
			@homes = {}
		end

		# years.each do |year|
		# 	puts year.to_s
		# 	ap house1.stats["year_#{year}"]
		# end

		# @homes.each_value {|i| puts i.year}

		def comma_numbers(number, delimiter = ',')
		  number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
		end

		def get_year_stats(year)
			equity = 0
			profit = 0
			debt = 0
			count = 0
			downpayment = 0
			cash_flow = 0
			@homes.each_value do |home|
				if year >= home.year
					index = year - home.year
					downpayment = home.downpayment if year == home.year
					equity = equity + home.stats.values[index][:principal]
					debt = debt + home.stats.values[index][:balance]
					profit = profit + home.stats.values[index][:profit]
					# puts home.get_cash_flow(year).to_s
					cash_flow = cash_flow + home.stats.values[index][:cash_flow]
					count += 1

				end
			end
			return {:equity => equity, :profit => (profit - downpayment), :debt => debt, :count => count, :cash_flow => cash_flow}
		end
end


#-------------------------------------------------------------
# 									Commandline Commands.
#-------------------------------------------------------------


	desc "new", "New rental house."
	def new (price, rate, insurance, term)
		house1 = House.new(price.to_i, rate.to_f, insurance.to_i, term.to_i)
		puts "Loan price = $#{house1.price}"
		puts "Loan rate = $#{house1.interest_rate}"
		puts "Downpayment = $#{house1.downpayment}"
		puts "Monthly Loan Payment = $#{house1.monthly_payment.round}"
		puts "Monthly Insurance = $#{house1.monthly_insurance}"
		puts "Monthly Taxes = $#{house1.monthly_taxes}"
		puts "Monthly PMI = $#{house1.monthly_pmi}"
		puts "Monthly Cost = $#{house1.monthly_cost.round}"
		puts "Proposed monly rent rate = $#{house1.rental_rate}"
		puts "Total paid to lender = $#{house1.total_loan_amount.round}"
		puts "Total interest paid to lender = $#{house1.total_loan_interest.round}"
		# puts "$#{house1.total_loan_paid(180)}"
		# puts "$#{house1.total_loan_owed(180)}"
	end

	desc "predict", "Random houses, predicts outcome and rental rate."
	def predict

		(1..30).each do |year|
			house_price = (150000 + rand(100000))
			#puts house_price
			insurance = 130
			term = 30

			@homes["house#{year}"] = House.new(house_price, 0.04, insurance, term)
		end

		# (1..60).each do |year|
		# 		stats = self.get_year_stats(year)
		# 		profit = self.comma_numbers(stats[:profit].round)
		# 		equity = self.comma_numbers(stats[:equity].round)
		# 		debt = self.comma_numbers(stats[:debt].round)
		# 		cash_flow = self.comma_numbers(stats[:cash_flow].round)
		# 		count = stats[:count]

		# 	#puts "In year #{year}; house count = #{count}; Equity = $#{equity}; Total debt = $#{debt}; Rental profit = $#{profit}; Cash Flow = $#{cash_flow}"

		# end
		ap @homes['house1'].stats
	end


end


Rental.start(ARGV)

