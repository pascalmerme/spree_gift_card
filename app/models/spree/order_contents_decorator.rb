Spree::OrderContents.class_eval do

  durably_decorate :grab_line_item_by_variant, mode: 'soft', sha: '31cfbf0d00135aad304c5f8131593e0f37964543' do |variant, *args|
    raise_error = args[0] || false

    if variant.product.is_gift_card?
      line_item = nil
    else
      line_item = order.find_line_item_by_variant(variant)
    end

    if !line_item.present? && raise_error
      raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
    end

    line_item
  end

end
