class CommentsController < ApplicationController
before_action :find_micropost, only: [:create]
before_action :find_comment , only: [:destroy]

def create
	@comment=@micropost.comments.create(params[:comment].permit(:content))
	@comment.user_id=current_user.id
	@comment.save

	if @comment.save
		respond_to do |format|
      	format.html { 
      		session[:return_to_com] ||= request.referer 
        	if session[:return_to_com]
          		redirect_to session.delete(:return_to_com)
        	else
          		redirect_to @user
        	end	}
      	format.js
	     	end
	
	else
		render 'new'
	end	
end

def destroy
	
	@comment.destroy
	respond_to do |format|
      	format.html { 
      		session[:return_to_com_del] ||= request.referer 
        	if session[:return_to_com_del]
          		redirect_to session.delete(:return_to_com_del)
        	else
          		redirect_to @user
        	end	}
      	format.js
	     	end
end

private
	
	def find_micropost
		@micropost = Micropost.find(params[:micropost_id])
	end

	def find_comment
		@comment = Comment.find(params[:id])
	end

end
