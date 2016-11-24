require "rails_helper"

RSpec.describe Suggestion, :type => :model do
  before :each do
    @product1 = Product.create!(code: 555, price: 15, type_t: 'sale')
    @product2 = Product.create!(code: 444, price: 14, type_t: 'purchase')
    @product3 = Product.create!(code: 333, price: 13, type_t: 'both')
    @product4 = Product.create!(code: 5555, price: 15, type_t: 'sale')
    @product5 = Product.create!(code: 4444, price: 15, type_t: 'purchase')
    @product6 = Product.create!(code: 3333, price: 15, type_t: 'both')
  end
  it 'should search by type' do
    expect(Suggestion.main_query(product_type_t: 'sale', queryString: @product1.code).to_a).to eq([@product1, @product4])
    expect(Suggestion.main_query(product_type_t: 'purchase', queryString: @product2.code).to_a).to eq([@product2, @product5])
    expect(Suggestion.main_query(product_type_t: 'both', queryString: @product3.code).to_a).to eq([@product3, @product6])
    expect(Suggestion.main_query(product_type_t: 'sale', queryString: @product4.code).to_a).to eq([@product4])
  end
end