require "rails_helper"

RSpec.describe Transaction, :type => :model do
  before :each do
    @product = Product.create!(code: 555, price: 10)
    @transaction_1 = Transaction.create!(product: @product, quantity: 10)
    @transaction_2 = Transaction.create!(product: @product, quantity: 10)
    @transaction_3 = Transaction.create!(product: @product, quantity: 10)
  end
  it 'should undo the last' do
    expect(Transaction.undo_last).to eq(true)
    expect(Transaction.last.status_t).to eq('undone')
  end
end