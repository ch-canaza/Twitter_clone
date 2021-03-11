# frozen_string_literal: true

# defines methods for CRUD
class UsersController < ApplicationController
  before_action :set_user, only: %i[show followers followees follow unfollow]

  USERS_PER_PAGE = 2

  def show
    @user_tweets = @user.tweet
  end

  def follow
    current_user.followees << @user
    redirect_to show_user_path(@user)
    flash[:notice] = 'You are now following this user'
  end

  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to show_user_path(@user)
  end

  def followers
    @page = params.fetch(:page, 0).to_i 
    @user_followers = @user.followers.offset(@page * USERS_PER_PAGE).limit(USERS_PER_PAGE).order('full_name')
  end

  def followees
    @page = params.fetch(:page, 0).to_i
    @user_followees = @user.followees.offset(@page * USERS_PER_PAGE).limit(USERS_PER_PAGE).order('full_name')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
