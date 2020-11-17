require 'rails_helper'
# require 'category'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "Validations" do
    it "is valid if all fields are valid" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: 100, quantity: 10, category: @category)
      expect(@product).to be_valid
    end

    it "is invalid if name is not present" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.messages[:name]).to include("can\'t be blank")
    end

    it "is invalid if price is not present" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: nil, quantity: 100, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.messages[:price]).to include("can\'t be blank")
    end

    it "is invalid if quantity is not present" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price_cents: 100, quantity: nil, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.messages[:quantity]).to include("can\'t be blank")
    end

    it "is invalid if category is not present" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'Test Product', price: 100, quantity: 10, category: nil)
      expect(@product).not_to be_valid
      expect(@product.errors.messages[:category]).to include("can\'t be blank")
    end

  end

end
