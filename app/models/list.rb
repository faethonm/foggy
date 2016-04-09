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

class List < ActiveRecord::Base
  belongs_to :user
  has_many  :list_items
  validates :name, presence: true
  before_save :downcase_name

  scope :search, -> (query) {
    where('lists.name like ?', "%#{query.try(:downcase) || ''}%")
  }

  scope :for_user, -> (email) {
    joins(:user).where('users.email = ?', email)
  }

  scope :not_for_user, -> (email) do
    joins(:user).where('users.email != ?', email)
  end

  private
  def downcase_name
    self.name = name.downcase
  end
end
