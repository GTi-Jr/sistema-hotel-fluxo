class DashboardController < BaseController
	def index
    @money_amount_in_cash_register = CashRegister.amount
	end
end
