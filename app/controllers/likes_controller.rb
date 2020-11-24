class LikesController < ApplicationController
    before_action :find_review
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
          flash[:notice] = "You can't like more than once"
        else
          @review.likes.create(user_id: current_user.id)
        end
        respond_to do |format|
            format.html { redirect_to review_path(@review) }
            format.js
        end
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like.destroy
        end
        respond_to do |format|
            format.html { redirect_to review_path(@review) }
            format.js
        end
      end

  private
    def find_review
        @review = Review.find(params[:review_id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, review_id:
        params[:review_id]).exists?
    end

    def find_like
        @like = @review.likes.find(params[:id])
    end
end