class Api::V1::Items::MerchantsController < ApplicationController
  before_action :set_item

  def show
    render json: MerchantSerializer.new(@item.merchant)
  end

  private

  def set_item
    @item = Item.find(params["item_id"])
  end
end
