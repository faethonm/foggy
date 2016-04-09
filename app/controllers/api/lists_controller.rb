class Api::ListsController < ApiController
  def index
    respond_to do |format|
      format.json { render text: List::ResponseMaker.new(params[:q]).run }
    end
  end
end
