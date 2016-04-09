# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'spec_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    it 'displays the home page' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /contact' do
    user = FactoryGirl.create(:user)
    context 'when user is logged in ' do
      it 'displays the contact page ' do
        login_as user, scope: :user
        get contact_path
        expect(response).to have_http_status(200)
      end
    end
    context 'when user is not logged in it should redirect to login' do
      it 'returns an error ' do
        get contact_path
        expect(response).to have_http_status(302)
        assert_redirected_to '/users/sign_in'
      end
    end
  end
end
