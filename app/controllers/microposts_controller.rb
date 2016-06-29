class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]

	def create
		@micropost = current_user.micropost.build(micropost_params)
		if @micropost.save
			flash[:success] = "Artwork posted!"
			redirect_to root_path
		else
  			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Artwork deleted"
		redirect_to request.referrer || root_url
	end

	def index
		if params[:search]
			@microposts = Micropost.search(params[:search]).paginate(page: params[:page])
		else
			@microposts = Micropost.paginate(page: params[:page])
		end
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :picture)
		end

		def correct_user
			@micropost = current_user.micropost.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end

end
