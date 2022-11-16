class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
    @review_id = params[:review_id]
    # @comment = current_user.comments.new(comment_params)
    # @game = Game.find(params[:id])
    @user = current_user
    # @review = @user.reviews
    # session[:previous_url] = request.referer
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    review = Review.find(comment_params[:review_id])
    game = review.game
    if @comment.save
      redirect_to game_path(game.id), notice: "登録が完了しました。"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to session[:previous_url], notice: "削除されました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:review_id, :comment)
  end
end
