# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @report = @user.reports.build(title: 'Sample Report', content: 'This is a sample report.')
  end

  test 'should be valid' do
    assert @report.valid?
  end

  test 'should require a title' do
    @report.title = '   '
    assert_not @report.valid?
  end

  test 'should require content' do
    @report.content = '   '
    assert_not @report.valid?
  end

  test 'editable? returns true when the same user' do
    assert @report.editable?(@user)
  end

  test 'editable? returns false when a different user' do
    other_user = users(:two)
    assert_not @report.editable?(other_user)
  end

  test 'should have the correct created_on date' do
    @report.created_at = Time.zone.now
    assert_equal @report.created_on, Date.today
  end
end
