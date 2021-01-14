class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.all
    json_response(@items)
  end

  # GET /items/:id
  def show
    json_response(@item)
  end

  # POST /items/:item_id
  def create
    @item = Item.create!(item_params)
    json_response(@item, :created)
  end

  private

  def item_params
    params.permit(:description, :upc, :price, :is_exempt)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
