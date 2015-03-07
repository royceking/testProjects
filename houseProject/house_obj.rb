class House
	attr_accessor :price, :downpayment, :taxes, :insurance, :interest_rate, :rental_rate, :monthly_payment, :loan_term, :loan_amount, :mip, :stats, :year
	def initialize(price, downpayment, taxes, interest_rate, insurance, loan_term, year)
		@price = price
		@downpayment = downpayment
		@loan_amount = price - downpayment
		@taxes = taxes
		@interest_rate = interest_rate
		@insurance = insurance
		@loan_term = loan_term
		@monthly_payment = self.get_monthly_payment
		@rental_rate = self.monthly_cost(200).round(-2)
		@stats = self.build_stats
		@year = year
	end
 
	def get_yearly_cost (extra_costs = 0)
		cost = (12 * @monthly_payment) + insurance + taxes + extra_costs
	end
 
	def get_value
		value = ((@loan_amount * 0.3) * @loan_term) + @loan_amount
	end
 
	def get_monthly_payment
		payments = @loan_term * 12
		monthly_rate = (@interest_rate/12)
		term = (1 + monthly_rate)**payments
		monthly_payment = @loan_amount * ((monthly_rate * term)/(term - 1))
		return monthly_payment
	end
 
	def get_mip
		value = @downpayment/@price
		rate = 0.008 if value > 0.05
		rate = 0.0085 if value < 0.05
		rate = 0 if value > 0.20
		mip = @loan_amount * rate
		return mip.round(2)
	end
 
	def total_loan_amount
		total = @monthly_payment * (@loan_term * 12)
	end
 
	def total_loan_interest
		total = self.total_loan_amount - @loan_amount
	end
	
	def total_loan_paid(payments)
		total = @monthly_payment * payments
	end
 
	def total_loan_owed(payments)
		total = self.total_loan_amount - self.total_loan_paid(payments) 
	end
 
	def total_cost
		total = self.total_loan_amount + self.total_taxes_paid + self.total_insurance_paid + self.total_mip_paid
	end
 
	def total_taxes_paid
		total = @taxes * @loan_term
	end
 
	def total_insurance_paid
		total = @insurance * @loan_term
	end
 
	def total_mip_paid
		total = @monthly_mip * 12 * @loan_term
	end
 
	def monthly_taxes
		total = @taxes/12
	end
 
	def monthly_insurance
		total = @insurance/12
	end
 
	def monthly_mip
		total = (self.get_mip/12).round(2)
	end
 
	def monthly_cost (extra_costs = 0)
		total = @monthly_payment + self.monthly_mip + self.monthly_taxes + self.monthly_insurance + extra_costs 
	end

	def build_stats
		stats = {}
		(@loan_term + 1).times do |year|
			payments = year * 12
			stats["year_#{year}"] = self.get_loan_stats(payments)
		end
		return stats

	end

	def get_loan_stats (payments)
		principal = @downpayment
		interest = 0
		balance = @loan_amount
		profit = 0
		(payments + 1).times do |p|
			unless p == 0
				payment_interest = (balance * @interest_rate)/12
				payment_principal = @monthly_payment - payment_interest
				principal = principal + payment_principal
				interest += payment_interest
				balance = balance - payment_principal
				profit = profit + (@rental_rate - @monthly_payment)
				# puts "Payment #{p} principal #{principal.round(2)}"
			end
		end
		return {:balance => balance.round(2), :principal => principal.round(2), :interest => interest.round(2), :profit => profit}
	end
end




