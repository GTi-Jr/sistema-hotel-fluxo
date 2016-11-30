require "rails_helper"

RSpec.describe CashRegister, type: :model do
  before :each do
    CashRegister.initiate!(insecure: true)
  end

  it 'should add a amount to the cash register' do
    CashRegister.add(100)
    expect(CashRegister.amount).to eq(100)
  end

  it 'should remove a amount from the cash register' do
    CashRegister.remove(70)
    expect(CashRegister.amount).to eq(-70)
  end
end
