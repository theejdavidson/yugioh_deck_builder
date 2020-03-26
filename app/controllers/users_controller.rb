class UsersController < ApplicationController
    before_action :authorized, only: [:index]
    
    def index
        @current_user = current_user
        @users = User.all
        get_followed_users
        @follows = Follow.all.select do |f|
            f.follower_id == @current_user.id
        end
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show 
        @user = current_user
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def get_other_users
        @other_users = @users.select do |user|
            user != current_user
        end
    end

    def get_followed_users
        get_other_users
        @followed_users = @other_users.select do |user|
            current_user.followings.include?(user)
        end
    end

    def get_followers 
    end
end