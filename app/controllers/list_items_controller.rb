# == Schema Information
#
# Table name: list_items
#
#  id         :integer          not null, primary key
#  name       :string
#  list_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_list_items_on_list_id  (list_id)
#

class ListItemsController < ApplicationController

  # def show
  #   @list_item = ListItem.find(params[:id])
  # end

  def new
    debugger
    @list_item = ListItem.new
  end

  def create
    @list = List.find(params[:id])
    @list_item = @list.list_items.create(list_items_params)
    if @list_item.save
      redirect_to @list_item
    else
      render 'new'
    end
  end

  private

  def list_item_params
    params.require(:list_item).permit(:name)
  end
end
