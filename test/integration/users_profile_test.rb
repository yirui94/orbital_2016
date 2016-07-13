require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:michael)
	end

	test "profile display" do
		get user_path(@user)
		assert_template 'users/show'
		
	end
end
