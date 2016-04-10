class AddInBasketToListItem < ActiveRecord::Migration
  def change
    add_column :list_items, :in_basket, :boolean
  end
end
