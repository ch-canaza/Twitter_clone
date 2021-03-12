# frozen_string_literal: true

# defines methods for CRUD
class UsersController < ApplicationController
  before_action :set_user, only: %i[show followers followees follow unfollow follow_another_user]
  before_action :set_page, only: %i[show followers followees]

  USERS_PER_PAGE = 10
  TWEETS_PER_PAGE = 10

  def show
    @user_tweets = @user.tweet.offset(@page * TWEETS_PER_PAGE).limit(TWEETS_PER_PAGE).order(created_at: :desc)
  end

  def follow
    if current_user.followees.include?(@user)
      flash[:notice] = 'You are already following this user'
      redirect_to show_user_path(@user)
    else
      current_user.followees << @user
      redirect_to show_user_path(@user)
      flash[:notice] = 'You are now following this user'
    end
  end

  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to show_user_path(@user)
    flash[:notice] = 'You just unfollow this user'
  end

  def followers
    @user_followers = @user.followers.offset(@page * USERS_PER_PAGE).limit(USERS_PER_PAGE).order('full_name')
  end

  def followees
    @user_followees = @user.followees.offset(@page * USERS_PER_PAGE).limit(USERS_PER_PAGE).order('full_name')
  end

  def follow_another_user
    if current_user.followees.include?(@user)
      flash[:notice] = 'You are already following this user'
    else
      current_user.followees << @user
      flash[:notice] = 'You are now following this user'
    end
    #redirect_to show_user_path(@user)
  end

  private

  def set_user
    @user = User.find_by(user_name: params[:id])
  end

  def set_page
    @page = params.fetch(:page, 0).to_i
  end
end
