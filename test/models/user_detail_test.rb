require 'test_helper'

class UserDetailTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
		@user_detail = @user.create_user_detail
	end

	test "should be valid" do
		assert @user_detail.valid?
	end
end
