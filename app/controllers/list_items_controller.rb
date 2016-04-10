# == Schema Information
#
# Table name: list_items
#
#  id         :integer          not null, primary key
#  name       :string
#  list_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  in_basket  :boolean
#
# Indexes
#
#  index_list_items_on_list_id  (list_id)
#

class ListItemsController < ApplicationController
  def new
    @list_item = ListItem.new
  end

  def create
    @list = List.find(params[:id])
    @list_item = @list.list_items.create(list_item_params)
    if @list_item.save
      redirect_to @list
    else
      render 'new'
    end
  end

  def destroy
    @list_item.destroy
    redirect_to request.referrer
  end

  def add_to_basket
  end

  private

  def list_item_params
    params.require(:list_item).permit(:name)
  end
end
