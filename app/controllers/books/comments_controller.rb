# frozen_string_literal: true

module Books
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book, only: %i[create]
    before_action :set_comment, only: [:destroy]
    before_action :correct_user, only: [:destroy]

    def create
      @comment = @book.comments.new(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to @book, notice: t('comments.successfully_created')
      else
        render 'books/show', status: :unprocessable_entity
      end
    end

    def destroy
      @comment.destroy
      redirect_to @comment.commentable, notice: t('comments.successfully_destroyed')
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:title, :content)
    end

    def correct_user
      redirect_to root_path, alert: t('comments.not_authorized') unless current_user == @comment.user
    end
  end
end
