if Spree::Product.gift_cards.count == 0
  puts "\tCreating default gift card..."
  shipping_category = Spree::ShippingCategory.create(name: 'Gift Card')

  stock_location = Spree::StockLocation.create_with(
    default: false,
  ).find_or_create_by(name: "Unlimited Digital Products")

  method = Spree::ShippingMethod.new(name: "Email Delivery")
  method.shipping_categories << shipping_category
  method.calculator = Spree::Calculator::Shipping::FlatRate.new(
    preferences: {
      amount: 0.0,
      currency: "GBP",
    }
  )
  method.zones << Spree::Zone.all

  method.save

  product = Spree::Product.new(available_on: Time.now, name: "Gift Card", is_gift_card: true, slug: 'gift-card', price: 0, shipping_category_id: shipping_category.id)

  option_type = Spree::OptionType.create_with(name: "is-gift-card", presentation: "Value").find_or_create_by(name: "is-gift-card")
  product.option_types << option_type
  [5, 10, 20, 30, 50, 100, 200, 500].each do |value|
    option_value = Spree::OptionValue.create_with(presentation: "$#{value}").find_or_create_by(name: value.to_s)
    option_value.option_type = option_type
    opts = { price: value.to_i, sku: "GIFTCERT#{value}" }
    variant = Spree::Variant.new(opts)

    stock_items = variant.stock_items.build
    stock_items.stock_location = stock_location
    stock_items.adjust_count_on_hand(10)

    variant.track_inventory = false

    variant.option_values << option_value
    product.variants << variant
  end
  product.save
end
