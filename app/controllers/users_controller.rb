class UsersController < ApplicationController
    before_action :authorized, only: [:index]
    
    def index
        @current_user = current_user
        @users = User.all
        get_other_users
        get_followed_users(@current_user)
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
        @user = User.find(params[:id])
        @decks = Deck.all.select {|deck| deck.user_id == @user.id}
        get_followers(@user)
        get_followed_users(@user)
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

    def get_followed_users(user)
        @users = User.all
        @followed_users = @users.select do |u|
            user.followings.include?(u)
        end
        @followed_num = @followed_users.count
    end

    def get_followers(user)
        @users = User.all
        @followers = @users.select do |u|
            u.followings.include?(user)
        end
        @followers_num = @followers.count
    end
end