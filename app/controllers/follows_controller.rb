class FollowsController < ApplicationController
    def create
        byebug
        followed = User.find(params[:followed_id])
        Follow.create(follower: current_user, followed: followed)
        redirect_to users_path
    end

    def destroy
        @follow = Follow.find(params[:id])
        @follow.destroy
        redirect_to users_path
    end

    private
    def follow_params
        params.permit(:follower_id, :followed_id)
    end
end