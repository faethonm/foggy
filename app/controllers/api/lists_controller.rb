class Api::ListsController < ApiController
  skip_before_filter :verify_authenticity_token
  def index
    respond_to do |format|
      format.json { render json: List::ResponseMaker.new(params[:q]).run }
    end
  end

  def show
    list = List.find params[:id]
    respond_to do |format|
      format.json { render json: List::ResponseMaker.new(params[:q]).show(list)}
    end
  end

  def create
    user = User.find_by(email: "james@foggy.io")
    list = List.create(name: params[:list_name], user: user)
    if list.valid?
      response = create_response(list)
    else
      response = {
        text: "You aready have a #{params[:list_name]} list for James.",
        status: "LIST_EXISTS",
        id: List.find_by(name: params[:list_name])
      }
    end
    respond_to do |format|
      format.json { render json: response }
    end
  end

  def update
    @list = List.find params[:id]

    respond_to do |format|
      format.json { render json: List::ListCreator.new(@list).run }
    end
  end

  private
  def create_response(list)
    {
      text: Response.list_create_text(list),
      status: 'CREATED_LIST',
      id: list.id
    }
  end
end
