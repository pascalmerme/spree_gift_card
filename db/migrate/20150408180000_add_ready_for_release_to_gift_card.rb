class AddReadyForReleaseToGiftCard < ActiveRecord::Migration
  def change
    add_column :spree_gift_cards, :ready_for_release, :boolean, default: false
  end
end
