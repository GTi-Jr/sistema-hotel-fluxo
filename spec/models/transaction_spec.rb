require "rails_helper"

RSpec.describe Transaction, :type => :model do
  before :each do
    CashRegister.initiate!(insecure: true)
    @product = Product.create!(code: 555, price: 10)
    @transaction_1 = Transaction.create!(product: @product, quantity: 10, type_t: 'sale')
    @transaction_2 = Transaction.create!(product: @product, quantity: 20, type_t: 'purchase')
    @transaction_3 = Transaction.create!(product: @product, quantity: 30, type_t: 'sale')
  end

  it 'should undo the last' do
    expect(Transaction.undo_last).to eq(true)
    expect(Transaction.last.status_t).to eq('undone')
  end

  it 'should add money to the cash register' do
    price = 0
    price += @transaction_1.price
    price -= @transaction_2.price
    price += @transaction_3.price
    expect(CashRegister.amount).to eq(price)
  end
end
