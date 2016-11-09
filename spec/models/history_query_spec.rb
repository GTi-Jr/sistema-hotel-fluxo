require "rails_helper"

RSpec.describe HistoryQuery, :type => :model do
  it 'should search by code' do
    product = Product.create!(code: 555)
    transaction = Transaction.create!(product: product)

    expect(HistoryQuery.main_query(code: 555).first.product_code).to eq(product.code)
  end

  it 'should search by date' do
    transactions = []
    transactions << product_1 = Transaction.create!(product_code: 111, data_t: Time.zone.now.to_date.yesterday)
    transactions << product_2 = Transaction.create!(product_code: 222, data_t: Time.zone.now.to_date.yesterday.yesterday)
    transactions << product_3 = Transaction.create!(product_code: 333, data_t: Time.zone.now.to_date.tomorrow)
    transactions << product_4 = Transaction.create!(product_code: 444, data_t: Time.zone.now.to_date)
    transactions << product_5 = Transaction.create!(product_code: 555, data_t: Time.zone.now.to_date)

    range_1 = "#{Time.zone.now.to_date.yesterday.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.strftime('%d/%m/%Y')}"
    range_2 = "#{Time.zone.now.to_date.yesterday.yesterday.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.tomorrow.strftime('%d/%m/%Y')}"
    range_3 = "#{Time.zone.now.to_date.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.strftime('%d/%m/%Y')}"

    expect(HistoryQuery.main_query(date_range: range_1).order(:product_code).to_a).to eq([product_1, product_4, product_5])
    expect(HistoryQuery.main_query(date_range: range_2).order(:product_code).to_a).to eq(transactions)
    expect(HistoryQuery.main_query(date_range: range_3).order(:product_code).to_a).to eq([product_4, product_5])
  end

  it 'should search by type' do
    transactions = []
    transactions << product_1 = Transaction.create!(type_t: :purchase)
    transactions << product_2 = Transaction.create!(type_t: :purchase)
    transactions << product_3 = Transaction.create!(type_t: :purchase)
    transactions << product_4 = Transaction.create!(type_t: :sale)
    transactions << product_5 = Transaction.create!(type_t: :sale)

    expect(HistoryQuery.main_query(type_t: :sale).to_a).to eq(transactions[3..4])
    expect(HistoryQuery.main_query(type_t: :purchase).to_a).to eq(transactions[0..2])
  end
end
