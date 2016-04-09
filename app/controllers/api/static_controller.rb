class Api::StaticController < ApiController
  def index
    render text: "Hello James!"
  end
end
