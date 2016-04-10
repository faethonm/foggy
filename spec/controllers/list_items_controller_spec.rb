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

require 'rails_helper'

RSpec.describe ListItemsController, type: :controller do
end
