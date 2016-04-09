class Api::ListsController < ApiController
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
end
