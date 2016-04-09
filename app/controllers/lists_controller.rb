class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.create(list_params)
    if @list.save
      redirect_to @list
    else
      render 'new'
    end

  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
