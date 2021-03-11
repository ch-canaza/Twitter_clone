# frozen_string_literal: true

# tweet controller, creates a redirection when logged in to post tweets.
class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Your tweet was succesfully posted.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet)
  end
end
