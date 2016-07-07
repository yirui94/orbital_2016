class UserDetailsController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]

	def edit
		@user_detail = current_user.user_detail
	end

	def update
	end

	private 

		def correct_user
			@user_detail = current_user.user_detail
			redirect_to root_url if @user_detail.nil?
		end
end
