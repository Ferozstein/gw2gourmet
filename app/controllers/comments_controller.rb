class CommentsController < ApplicationController
  
  def add

  	@comment = Comment.new(comment_params)
  	# Comment.create(body: params[:body], user_id: params[:user_id], item_id: params[:item_id])
  	

  end

  private

  def comment_params
  	params.require(:comment).permit(:body, :user_id, :item_id)
  end


end
