require "rails_helper"

RSpec.describe HistoryQuery, :type => :model do
  it 'should search by code' do
    product = Product.create!(code: 555)
    transaction = Transaction.create!(product: product)

    expect(HistoryQuery.main_query(code: 555).first.product_code).to eq(product.code)
  end

  it 'should search by date' do
    transactions = []
    transactions << transaction_1 = Transaction.create!(product_code: 111, data_t: Time.zone.now.to_date.yesterday)
    transactions << transaction_2 = Transaction.create!(product_code: 222, data_t: Time.zone.now.to_date.yesterday.yesterday)
    transactions << transaction_3 = Transaction.create!(product_code: 333, data_t: Time.zone.now.to_date.tomorrow)
    transactions << transaction_4 = Transaction.create!(product_code: 444, data_t: Time.zone.now.to_date)
    transactions << transaction_5 = Transaction.create!(product_code: 555, data_t: Time.zone.now.to_date)

    range_1 = "#{Time.zone.now.to_date.yesterday.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.strftime('%d/%m/%Y')}"
    range_2 = "#{Time.zone.now.to_date.yesterday.yesterday.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.tomorrow.strftime('%d/%m/%Y')}"
    range_3 = "#{Time.zone.now.to_date.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.strftime('%d/%m/%Y')}"

    expect(HistoryQuery.main_query(date_range: range_1).order(:product_code).to_a).to eq([transaction_1, transaction_4, transaction_5])
    expect(HistoryQuery.main_query(date_range: range_2).order(:product_code).to_a).to eq(transactions)
    expect(HistoryQuery.main_query(date_range: range_3).order(:product_code).to_a).to eq([transaction_4, transaction_5])
  end

  it 'should search by type' do
    transactions = []
    transactions << transaction_1 = Transaction.create!(type_t: :purchase)
    transactions << transaction_2 = Transaction.create!(type_t: :purchase)
    transactions << transaction_3 = Transaction.create!(type_t: :purchase)
    transactions << transaction_4 = Transaction.create!(type_t: :sale)
    transactions << transaction_5 = Transaction.create!(type_t: :sale)

    expect(HistoryQuery.main_query(type_t: :sale).to_a).to eq(transactions[3..4])
    expect(HistoryQuery.main_query(type_t: :purchase).to_a).to eq(transactions[0..2])
  end

  it 'should search by department' do
    department_1 = Department.create!
    department_2 = Department.create!

    product_1 = Product.create!(department: department_1, code: 111)
    product_2 = Product.create!(department: department_2, code: 222)

    transactions = []

    transactions << transaction_1 = Transaction.create!(product: product_1)
    transactions << transaction_2 = Transaction.create!(product: product_1)
    transactions << transaction_3 = Transaction.create!(product: product_2)
    transactions << transaction_4 = Transaction.create!(product: product_2)
    transactions << transaction_5 = Transaction.create!(product: product_2)

    expect(HistoryQuery.main_query(department_id: department_1.id).to_a).to eq(transactions[0..1])
    expect(HistoryQuery.main_query(department_id: department_2.id).to_a).to eq(transactions[2..4])
  end
end
