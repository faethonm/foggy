class Api::ListsController < ApiController
  def index
    @lists = List.search params[:q]
    respond_to do |format|
      format.json { render json: @lists.to_json }
    end
  end
end
