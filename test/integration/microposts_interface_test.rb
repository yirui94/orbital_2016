require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "micropost interface" do 
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'

		#invalid submission
		assert_no_difference 'Micropost.count' do
			post microposts_path, micropost: { content: ""}
		end
		assert_select 'div#error_explanation'

		# valid submission

		# delete post
		assert_select 'a', text: 'delete'
		first_micropost = @user.micropost.paginate(page: 1).first
		assert_difference 'Micropost.count', -1 do
			delete micropost_path(first_micropost)
		end

		# Visit different user
		get user_path(users(:archer))
		assert_select 'a', text: 'delete', count: 0
	end
end
