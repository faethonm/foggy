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

class List < ActiveRecord::Base
  belongs_to :user
  validates :name,  presence: true

  scope :search, -> (query) {
    search_query = "%#{query.downcase}%"
    where("lists.name like ?", search_query)
  }
end
