require "rails_helper"

RSpec.describe HistoryQuery, :type => :model do
  it 'should search by code' do
    product = Product.create!(code: 555)
    transaction = Transaction.create!(product: product)

    expect(HistoryQuery.main_query(code: 555).first).to eq(Transaction.first)
  end

  it 'should search by date' do
    product_1 = Transaction.create!(product_code: 111, data_t: Date.yesterday)
    product_2 = Transaction.create!(product_code: 222, data_t: Date.yesterday.yesterday)
    product_3 = Transaction.create!(product_code: 333, data_t: Date.tomorrow)
    product_4 = Transaction.create!(product_code: 444, data_t: Date.today)

    range_1 = "#{Date.yesterday.strftime('%d/%m/%Y')} - #{Date.today.strftime('%d/%m/%Y')}"

    expect(HistoryQuery.main_query(date_range: range_1).order(:product_code).to_a).to eq([product_1, product_3])
  end
end
