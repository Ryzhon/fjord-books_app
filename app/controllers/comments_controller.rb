# frozen_string_literal: true

# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('comments.successfully_created')
    else
      redirect_to @commentable, alert: t('comments.unable_to_create')
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('comments.successfully_destroyed')
  end

  private

  def find_commentable
    params.each do |name, value|
      return Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def correct_user
    redirect_to root_url, alert: 'Not authorized to delete this comment.' unless current_user == @comment.user
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
