class Api::StaticController < ApiController
  def index
    render text: Response.static_text
  end
end
