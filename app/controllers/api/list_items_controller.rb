class Api::ListItemsController < ApiController
  skip_before_filter :verify_authenticity_token
  def create
    list = current_user.lists.find_by(name: params[:list_name])

    list_item = list.list_items.create!(name: params[:item_name])

    respond_to do |format|
      format.json { render json: create_response(list_item) }
    end
  end

  def add_to_basket
    list = current_user.lists.find_by(name: params[:list_name])

    list_item = list.list_items.find_by(name: params[:item_name])

    list_item.update_attributes!(in_basket: true)

    respond_to do |format|
      format.json { render json: add_to_basket_response(list_item), status: :created }
    end
  end

  private
  def create_response(list_item)
    {
      text: Response.list_item_create_text(list_item),
      status: "CREATED_LIST_ITEM",
      id: list_item.list.id
    }
  end

  def add_to_basket_response(list_item)
    {
      text: Response.add_to_basket_text(list_item),
      status: "ADDED_TO_BASKET",
      id: list_item.list.id
    }
  end
end
