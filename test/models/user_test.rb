# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  test 'should follow and unfollow a user' do
    alice = users(:one)
    bob = users(:two)
    assert_not alice.following?(bob)
    alice.follow(bob)
    assert alice.following?(bob)
    assert bob.followed_by?(alice)
    alice.unfollow(bob)
    assert_not alice.following?(bob)
  end
end
