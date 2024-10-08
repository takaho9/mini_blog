class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authorize_user, only: %i[ edit update ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.includes(:likes).order(created_at: :desc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    @user.user_blogs.length.upto(9) { @user.user_blogs.build }
  end

  def update
    @user = User.find(params[:id])
    clean_user_blogs_params

    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def clean_user_blogs_params
      return unless params[:user] && params[:user][:user_blogs_attributes]

      params[:user][:user_blogs_attributes].each do |key, attributes|
        if attributes[:url].blank?
          attributes[:_destroy] = "1"
        end
      end
    end

    def user_params
      params.require(:user).permit(:profile_message, user_blogs_attributes: %i[ id url kind _destroy ])
    end

    def authorize_user
      unless helpers.self_user?(@user)
        redirect_to root_path, alert: "You are not authorized to do that."
      end
    end
end
