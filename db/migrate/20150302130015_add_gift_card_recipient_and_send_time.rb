class AddGiftCardRecipientAndSendTime < ActiveRecord::Migration
  def change
    add_column :spree_gift_cards, :sender_name, :string
    add_column :spree_gift_cards, :recipient_email, :string
    add_column :spree_gift_cards, :send_method, :string # "delay" or "instant"
    add_column :spree_gift_cards, :send_at, :date
  end
end
