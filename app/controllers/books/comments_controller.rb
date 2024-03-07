# frozen_string_literal: true

module Books
  class CommentsController < CommentController
    private

    def set_commentable
      @commentable = Book.find(params[:book_id])
    end

    def render_template_for
      'books/show'
    end
  end
end
