class UserDetailsController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]

	def edit
		@user_detail = current_user.user_detail
	end

	def update
		@user_detail = current_user.user_detail
	  	if @user_detail.update_attributes(user_detail_params)
	  		flash[:success] = "Profile updated"
	  		redirect_to current_user
	  	else
	  		render 'edit'
	  	end
	end

	private 

		def user_detail_params
			params.require(:user_detail).permit(:introduction, :website,
												:country, :medium)
		end

		def correct_user
			@user_detail = current_user.user_detail
			redirect_to root_url if @user_detail.nil?
		end
end
