class SimpleSearchesController < ApplicationController
  before_action :item_setting, only: :index

  def index
    @keyword = params[:keyword]
    @items = Item.where('name LIKE(?) OR content  LIKE(?)',"%#{params[:keyword]}%","%#{params[:keyword]}%").page(params[:page]).per(20)
    @search = Item.ransack(params[:q])
    @new_items = Item.order("created_at DESC").limit(20)
  end

  private
    def item_setting
    @upper_categories = UpperCategory.all.includes([middle_categories: :lower_categories])
    @middle_categories = MiddleCategory.all.where(upper_category_id: params[:upper_category_id])
    @lower_categories = LowerCategory.all.where(middle_category_id: params[:middle_category_id])
    @sizes = Size.all.where(size_type_id: 1)
    @delivery_methods = DeliveryMethod.all
    @delivery_burdens = DeliveryBurden.all
    @conditions = Condition.all
    @statuses = Status.all
  end
end