module Api
  class ListsController < ApiController
    def index
      @lists = List.search params[:q]
      respond_to do |format|
        format.json { render @lists.to_json }
      end
    end
  end
end
