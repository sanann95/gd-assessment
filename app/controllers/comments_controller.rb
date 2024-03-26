class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    user_id = comment_params[:user_id]
    user = User.find(user_id)
    commenter_name = user.name
    @comment = @article.comments.create(comment_params.merge(commenter: commenter_name))
    redirect_to article_path(@article)
  end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :body, :status)
    end
end
