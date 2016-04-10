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
    list = List.create!(name: params[:name])
    respond_to do |format|
      format.json { render json: create_response(list) }
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
      text: "I've created the #{list.name} list for you. Do you want to add items to it?",
      status: "CREATED_LIST",
      id: list.id
    }
  end
end
