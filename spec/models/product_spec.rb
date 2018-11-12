require 'rails_helper'

RSpec.describe Product, type: :model do

  before :each do
    @category = Category.new(name: 'testing-category')
  end

  describe 'Validations' do

    it 'should return true for all parameters set correctly and saved' do
      @product = @category.products.new({
        name:  'Testing product1',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(@product.save).to be true
    end

    it 'should return true for all parameters set correctly' do
      @product = @category.products.new({
        name:  'Testing product',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(@product.valid?).to be true
    end

    it 'should return false if name not set' do
      @product = @category.products.new({
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(@product.valid?).to be false
    end

    it 'should return false if price not set' do
      @product = @category.products.new({
        name:  'Testing product',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10
      })
      expect(@product.valid?).to be false
    end

    it 'should return false if quantity not set' do
      @product = @category.products.new({
        name:  'Testing product',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        price: 64.99,
      })
      expect(@product.valid?).to be false
    end

    it 'should return false if category not set' do
      @product = Product.new({
        name:  'Testing product',
        price: 64.99,
        quantity: 10
      })
      expect(@product.valid?).to be false
    end

    it 'should return true if description not set' do
      @product = @category.products.new({
        name:  'Testing product',
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99
      })
      expect(@product.valid?).to be true
    end

    it 'should return true if image not set' do
      @product = @category.products.new({
        name:  'Testing product',
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      })
      expect(@product.valid?).to be true
    end



  end

end
