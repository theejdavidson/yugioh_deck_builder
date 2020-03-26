class UsersController < ApplicationController
    before_action :authorized, only: [:index]
    
    def index
        @current_user = current_user
        @users = User.all
        @other_users = @users.select do |user|
            user != @current_user
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
end