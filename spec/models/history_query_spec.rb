require "rails_helper"

RSpec.describe HistoryQuery, :type => :model do
  before :each do
    @department_1 = Department.create!
    @department_2 = Department.create!
    @product_1 = Product.create!(code: 111, price: 10, department: @department_1, stock: 3)
    @product_2 = Product.create!(code: 222, price: 20, department: @department_2)
    @product_3 = Product.create!(code: 333, price: 30, department: @department_1)
    @product_4 = Product.create!(code: 444, price: 40, department: @department_2)
    @product_5 = Product.create!(code: 555, price: 50, department: @department_1)
  end

  it 'should search by code' do
    transaction = Transaction.create!(product: @product_1, quantity: 2)
    expect(HistoryQuery.main_query(code: transaction.product_code).first.product_code).to eq(@product_1.code)
  end

  it 'should search by date' do
    transactions = []
    transactions << transaction_1 = Transaction.create!(product: @product_1, data_t: Time.zone.now.to_date.yesterday, quantity: 2)
    transactions << transaction_2 = Transaction.create!(product: @product_2, data_t: Time.zone.now.to_date.yesterday.yesterday, quantity: 2)
    transactions << transaction_3 = Transaction.create!(product: @product_3, data_t: Time.zone.now.to_date.tomorrow, quantity: 2)
    transactions << transaction_4 = Transaction.create!(product: @product_4, data_t: Time.zone.now.to_date, quantity: 2)
    transactions << transaction_5 = Transaction.create!(product: @product_5, data_t: Time.zone.now.to_date, quantity: 2)

    range_1 = "#{Time.zone.now.to_date.yesterday.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.strftime('%d/%m/%Y')}"
    range_2 = "#{Time.zone.now.to_date.yesterday.yesterday.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.tomorrow.strftime('%d/%m/%Y')}"
    range_3 = "#{Time.zone.now.to_date.strftime('%d/%m/%Y')} - #{Time.zone.now.to_date.strftime('%d/%m/%Y')}"

    expect(HistoryQuery.main_query(date_range: range_1).order(:product_code).to_a).to eq([transaction_1, transaction_4, transaction_5])
    expect(HistoryQuery.main_query(date_range: range_2).order(:product_code).to_a).to eq(transactions)
    expect(HistoryQuery.main_query(date_range: range_3).order(:product_code).to_a).to eq([transaction_4, transaction_5])
  end

  it 'should search by type' do
    transactions = []
    transactions << transaction_1 = Transaction.create!(product: @product_1, type_t: :purchase, quantity: 2)
    transactions << transaction_2 = Transaction.create!(product: @product_1, type_t: :purchase, quantity: 2)
    transactions << transaction_3 = Transaction.create!(product: @product_1, type_t: :purchase, quantity: 2)
    transactions << transaction_4 = Transaction.create!(product: @product_1, type_t: :sale, quantity: 2)
    transactions << transaction_5 = Transaction.create!(product: @product_1, type_t: :sale, quantity: 2)

    expect(HistoryQuery.main_query(type_t: :sale).to_a).to eq(transactions[3..4])
    expect(HistoryQuery.main_query(type_t: :purchase).to_a).to eq(transactions[0..2])
  end

  it 'should search by department' do
    transactions = []
    transactions << transaction_1 = Transaction.create!(product: @product_1, quantity: 2)
    transactions << transaction_2 = Transaction.create!(product: @product_1, quantity: 2)
    transactions << transaction_3 = Transaction.create!(product: @product_2, quantity: 2)
    transactions << transaction_4 = Transaction.create!(product: @product_2, quantity: 2)
    transactions << transaction_5 = Transaction.create!(product: @product_2, quantity: 2)

    expect(HistoryQuery.main_query(department_id: @department_1.id).to_a).to eq(transactions[0..1])
    expect(HistoryQuery.main_query(department_id: @department_2.id).to_a).to eq(transactions[2..4])
  end
end
