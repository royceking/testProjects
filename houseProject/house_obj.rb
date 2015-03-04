class House
	attr_accessor :price, :downpayment, :taxes, :insurance, :interest_rate, :rental_rate, :monthly_payment, :loan_term, :loan_amount, :mip
	def initialize(price, downpayment, taxes, interest_rate, insurance, loan_term)
		@price = price
		@downpayment = downpayment
		@loan_amount = price - downpayment
		@taxes = taxes
		@interest_rate = interest_rate
		@insurance = insurance
		@loan_term = loan_term
		@monthly_payment = self.get_monthly_payment
		@rental_rate = self.monthly_cost(200)
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
		return monthly_payment.round
	end
 
	def get_mip
		value = @downpayment/@price
		rate = 0.008 if value > 0.05
		rate = 0.0085 if value < 0.05
		rate = 0 if value > 0.20
		mip = @loan_amount * rate
		return mip.round
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
		total = self.get_mip/12
	end
 
	def monthly_cost (extra_costs = 0)
		total = @monthly_payment + self.monthly_mip + self.monthly_taxes + self.monthly_insurance + extra_costs 
	end
end

