class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		@micropost = current_user.micropost.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	else
      @micropost = Micropost.random.take(3)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
