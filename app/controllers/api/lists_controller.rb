class Api::ListsController < ApiController
  def index
    respond_to do |format|
      format.json { render json: List::ResponseMaker.new(params[:q], params[:user]).run }
    end
  end
end
