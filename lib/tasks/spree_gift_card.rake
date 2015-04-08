# add custom rake tasks here
namespace :spree_gift_card do
  desc "Deliver delayed gift cards"
  task :deliver_delayed => :environment do
    Spree::GiftCard.due_for_delivery.each do |gift_card|
      gift_card.deliver!
    end
  end
end
