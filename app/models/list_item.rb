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

class ListItem < ActiveRecord::Base
  belongs_to :list

  before_save :downcase_name

  private
  def downcase_name
    self.name = name.downcase
  end
end
