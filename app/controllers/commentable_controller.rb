# frozen_string_literal: true

class CommentableController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('comments.successfully_created')
    else
      render render_template_for(@commentable), status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t('comments.successfully_destroyed')
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def correct_user
    redirect_to root_path, alert: t('comments.not_authorized') unless current_user == @comment.user
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end

  def render_template_for(commentable)
    model_name = commentable.model_name.plural
    "#{model_name}/show"
  end
end
