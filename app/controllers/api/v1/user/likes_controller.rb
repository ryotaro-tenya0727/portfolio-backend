class Api::V1::User::LikesController < ApplicationController
  def create
    authorize([:user, Like])
    ActiveRecord::Base.transaction do
      diary = Diary.find(params[:id])
      current_user.like(diary)
    end
    head :ok
  end

  def destroy
    authorize([:user, Like])
    ActiveRecord::Base.transaction do
      diary = Diary.find(params[:id])
      current_user.unlike(diary)
    end
    head :ok
  end
end
