require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "They can add item to cart" do
    
    #ACT
    visit root_path
    save_screenshot 'add_to_cart_1.png'
    click_button('Add', :match => :first)


    # DEBUG/VERIFY
    expect(page).to have_text("My Cart (1)")
    save_screenshot 'add_to_cart_2.png'

  end

end
