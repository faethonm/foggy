class Api::ListItemsController < ApiController
  skip_before_filter :verify_authenticity_token
  def create
    if list = current_user.lists.find_by(name: params[:list_name])
      list_item = list.list_items.create(name: params[:item_name])
      if list_item.valid?
        response = create_response(list_item)
      else
        response = {
          text: "#{params[:item_name]} is already in your #{params[:list_name]} list.",
          status: "ITEM_EXISTS"
        }
      end
    else
      response = {
        text: "I couldn't find #{params[:list_name]} for James. Would you like to create one?",
        status: "NOT_FOUND"
      }
    end

    respond_to do |format|
      format.json { render json: response }
    end
  end

  def add_to_basket
    if list = current_user.lists.find_by(name: params[:list_name])
      if list_item = list.list_items.find_by(name: params[:item_name])
        list_item.update_attributes!(in_basket: true)

        response = add_to_basket_response(list_item)
      else
        response = {
          text: "I couldn't find #{params[:item_name]} in your #{params[:list_name]} list",
          status: "ITEM_NOT_FOUND"
        }
      end
    else
      response = {
        text: "I couldn't find a #{params[:list_name]} list for James. Would you like to create one?",
        status: "NOT_FOUND"
      }
    end

    respond_to do |format|
      format.json { render json: response }
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
