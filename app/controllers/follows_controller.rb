class FollowsController < ApplicationController
    def create
        Follow.create(follow_params)
        redirect_to users_path
    end

    def destroy
        @follow = Follow.find(params[:id])
        @follow.destroy
        redirect_to users_path
    end

    private
    def follow_params
        params.require(:follow).permit(:follower_id, :followed_id)
    end
end