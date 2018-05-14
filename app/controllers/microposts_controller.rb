class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    if params[:tag]
    @microposts = Micropost.tagged_with(params[:tag])
    else
    @microposts = Micropost.paginate(page: params[:page])
    end
    @comments=Comment.where(micropost_id:@micropost).order("created_at DESC")
  end
  
  
  
     
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      new_text = @micropost.content.gsub(/#[a-zA-Z0-9_]*/) do |match|
      @micropost.tag_list.add(match)
      @micropost.save
      @micropost.reload
    end
    redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

   private

    def micropost_params
      params.require(:micropost).permit(:content, :picture , :tag_list) 
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
