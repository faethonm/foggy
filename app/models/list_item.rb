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

class ListItem < ActiveRecord::Base
  belongs_to :list
  validates :name, uniqueness: { scope: :list_id }

  before_save :downcase_name

  scope :items_in_basket, -> () { where(in_basket: true) }

  def toggle_basket
    self.in_basket = !in_basket
  end

  private

  def downcase_name
    self.name = name.downcase
  end


end
