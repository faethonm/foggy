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

require 'rails_helper'

RSpec.describe List, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
