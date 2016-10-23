class TransactionQuery < ActiveRecord::Base

  def self.main_query(options = {})
    options[:initiald_date]
  end

  
end
