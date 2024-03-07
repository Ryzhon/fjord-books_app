# frozen_string_literal: true

module Reports
  class CommentsController < CommentController
    private

    def set_commentable
      @commentable = Report.find(params[:report_id])
    end

    def render_template_for
      'reports/show'
    end
  end
end
