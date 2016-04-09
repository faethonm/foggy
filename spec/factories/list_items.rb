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

FactoryGirl.define do
  factory :list_item do
    name "MyString"
    list nil
  end
end
