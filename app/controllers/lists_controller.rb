# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_lists_on_user_id  (user_id)
#

class ListsController < ApplicationController
  enable_sync only: [:create, :update, :destroy]
  before_action :authenticate_user!

  def index
    @lists = current_user.lists.order(created_at: :desc)
    @list_item = ListItem.new
  end

  def show
    @list = List.find(params[:id])
    @list_item = ListItem.new
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.create(list_params)
    @list_items = @list_items
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
