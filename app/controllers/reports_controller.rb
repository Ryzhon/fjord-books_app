# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  before_action :set_report, only: %i[show edit update destroy create_comment]

  def index
    @reports = Report.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to report_path(@report), notice: t('reports.successfully_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to report_path(@report), notice: t('reports.successfully_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: t('reports.successfully_destroyed')
  end

  def create_comment
    @comment = @report.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @report, notice: t('comments.successfully_created')
    else
      redirect_to @report, alert: t('comments.unable_to_create')
    end
  end

  private

  def correct_user
    @report = current_user.reports.find(params[:id])
    redirect_to root_path if @report.nil?
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
