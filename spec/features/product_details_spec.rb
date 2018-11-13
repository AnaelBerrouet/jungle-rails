require 'rails_helper'

RSpec.feature "User visits product details", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product details page" do
    #ACT
    visit root_path

    click_link('Details »', match: :first)
    sleep(1.seconds)

    #DEBUG / VERIFY
    save_screenshot
    # expect(page).to have_css 'article.product-detail'
    expect(page).to have_css('h2', text: 'Reviews:')
  end

end
