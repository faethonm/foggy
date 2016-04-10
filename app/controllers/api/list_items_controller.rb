class Api::ListItemsController < ApiController
  skip_before_filter :verify_authenticity_token
  def create
    list = User.find_by(email: "james@foggy.io").lists.find_by(name: params[:list_name])

    list_item = list.list_items.create!(name: params[:item_name])

    respond_to do |format|
      format.json { render json: create_response(list_item) }
    end
  end

  private
  def create_response(list_item)
    {
      text: "I've added #{list_item.name} to #{list_item.list.name}.",
      status: "CREATED_LIST_ITEM",
      id: list_item.list.id
    }
  end
end
