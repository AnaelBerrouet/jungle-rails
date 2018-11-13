require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'After creation' do
    before :each do

      @category = Category.create!(name: 'testing-category')

      # Setup at least two products with different quantities, names, etc
      @product1 = @category.products.create!({
        name:  'Clossy shirt',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel1.jpg',
        quantity: 10,
        price: 64.99,
      })
      @product2 = @category.products.create!({
        name:  'Zoobra pants',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel2.jpg',
        quantity: 20,
        price: 124.99
      })
      # Setup at least one product that will NOT be in the order
      @product3 = @category.products.create!({
        name:  'Clossy pants',
        description: Faker::Hipster.paragraph(4),
        image: 'apparel2.jpg',
        quantity: 20,
        price: 124.99
      })
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do

      # TODO: Implement based on hints below

      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new({
        email: "user@example.com",
        total_cents: 0,
        stripe_charge_id: "123124214", #some id
      })

      # 2. build line items on @order
      quantity = 5
      @order.line_items.new(
        product: @product1,
        quantity: quantity,
        item_price: @product1.price,
        total_price: @product1.price * quantity
      )
      quantity = 10
      @order.line_items.new(
        product: @product2,
        quantity: quantity,
        item_price: @product2.price,
        total_price: @product2.price * quantity
      )

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!

      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(5)
      expect(@product2.quantity).to eq(10)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      expect(@product3.quantity).to be 20
    end
  end

end
