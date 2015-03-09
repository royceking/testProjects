class House
	attr_accessor :price, :downpayment, :taxes, :insurance, :interest_rate, :rental_rate, :monthly_payment, :loan_term, :loan_amount, :pmi, :stats, :year
	def initialize(price, interest_rate, insurance, loan_term)
		@price = price
		@downpayment = price * 0.10
		@loan_amount = price - downpayment
		@taxes = price * 0.006
		@interest_rate = interest_rate
		@insurance = insurance
		@loan_term = loan_term
		@monthly_payment = self.get_monthly_payment
		@rental_rate = self.monthly_cost(200).round(-2)
		@stats = self.build_stats
		@year = 0
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

	def after_loan_profit
		profit = @rental_rate - (self.monthly_taxes + self.monthly_insurance)
	end
 
	def get_pmi
		value = @downpayment/@price
		rate = 0.008 if value > 0.05
		rate = 0.0085 if value < 0.05
		rate = 0 if value > 0.20
		pmi = @loan_amount * rate
		return pmi.round(2)
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
		total = self.total_loan_amount + self.total_taxes_paid + self.total_insurance_paid + self.total_pmi_paid
	end
 
	def total_taxes_paid
		total = @taxes * @loan_term
	end
 
	def total_insurance_paid
		total = @insurance * @loan_term
	end
 
	def total_pmi_paid
		total = @monthly_pmi * 12 * @loan_term
	end
 
	def monthly_taxes
		total = @taxes/12
	end
 
	def monthly_insurance
		total = @insurance/12
	end
 
	def monthly_pmi
		total = (self.get_pmi/12).round(2)
	end
 
	def monthly_cost (extra_costs = 0)
		total = @monthly_payment + self.monthly_pmi + self.monthly_taxes + self.monthly_insurance + extra_costs 
	end

	def build_stats
		stats = {}
		y = @year
		(1..60).each do |year|
			payments = year * 12
			stats["year_#{year}"] = self.get_loan_stats(payments)
		end
		return stats
	end

	def get_cash_flow(year)
		pmi = self.monthly_pmi
		pmi = 0 if year > 5
		cash_flow = (@rental_rate - (@monthly_payment + pmi + self.monthly_taxes + self.monthly_insurance))* 12
		cash_flow = (@rental_rate - (self.monthly_taxes + self.monthly_insurance)) * 12 if year > 30
		return cash_flow
	end

	def get_loan_stats (payments)
		principal = @downpayment
		interest = 0
		balance = @loan_amount
		profit = 0
		(1..payments).each do |p|
			pmi = self.monthly_pmi
			pmi = 0 if p > 75
			payment_interest = (balance * @interest_rate)/12
			payment_principal = @monthly_payment - payment_interest
			if p <= 360
				principal = principal + payment_principal
				interest += payment_interest
				balance = balance - payment_principal
				profit = profit + (@rental_rate - (@monthly_payment + pmi + self.monthly_taxes + self.monthly_insurance))
			else
				profit = profit + (@rental_rate - (self.monthly_taxes + self.monthly_insurance))
			end

		end
		return {:balance => balance.round(2), :principal => principal.round(2), :interest => interest.round(2), :profit => profit, :cash_flow => self.get_cash_flow(payments/12)}
	end
end




