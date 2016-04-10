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
    if params[:q]
      search_param = "%#{params[:q]}%"
      @lists = List
        .where("name like ?", search_param).all.order(:user_id).order(created_at: :desc)
      @list_item = ListItem.new
      respond_to do |format|
        format.html
      end

    else
      @lists = current_user.lists.order(:user_id).order(created_at: :desc)
      @list_item = ListItem.new
    end
    
  end

  def show
    @list = List.find(params[:id])
    @list_item = ListItem.new
  end

  def new
    @list = List.new
  end

  def destroy
    debugger
    @list.destroy
    redirect_to request.referrer || root_url
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

  def copy
    current_list = List.find(params[:id])
    @list = current_list.dup
    @list.update_attributes!(user: current_user)
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
