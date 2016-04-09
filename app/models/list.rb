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
  has_many :list_items

  scope :search, -> (query) {
    search_query = "%#{query.try(:downcase) || ''}%"
    where("lists.name like ?", search_query)
  }

  scope :for_user, -> (email) {
    joins(:user).where("users.email = ?", email)
  }

  scope :not_for_user, -> (email) {
    joins(:user).where("users.email != ?", email)
  }
end
