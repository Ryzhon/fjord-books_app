# frozen_string_literal: true

module Reports
  class CommentsController < CommentableController
    private

    def set_commentable
      @commentable = Report.find(params[:report_id])
    end
  end
end
