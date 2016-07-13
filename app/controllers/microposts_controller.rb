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
			@microposts = Micropost.has_title(params[:search]).paginate(page: params[:page])
		else
			@microposts = Micropost.paginate(page: params[:page])
		end
		@microposts = @microposts.has_country(params[:country]) if params[:country].present?
   		@microposts = @microposts.has_medium(params[:medium]) if params[:medium].present?
   		@microposts = @microposts.has_width(params[:width]) if params[:width].present?
   		@microposts = @micropost.has_height(params[:height]) if params[:height].present?
   		
   		if params[:price]
   			@microposts = @microposts.has_price(params[:price]).by_price
   		end
	end

	def show
  		@micropost = Micropost.find(params[:id])
  		@user = @micropost.user
    	@user_detail = @user.user_detail
	    if !@user_detail.country.blank?
	      @user_detail.country = ISO3166::Country.find_country_by_alpha2(@user_detail.country).name
	    end
	end

	def edit

	end

	def update

	end

	private

		def micropost_params
			params.require(:micropost).permit(:title, :content, :picture, :width, :height, :price, :medium)
		end

		def correct_user
			@micropost = current_user.micropost.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end

end
