# frozen_string_literal: true

# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('comments.successfully_destroyed')
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def correct_user
    redirect_to root_url, alert: 'Not authorized to delete this comment.' unless current_user == @comment.user
  end
end
