class UpvotesController < ApplicationController

  def new
    @blurt1, @blurt2 = Upvote.two_blurts
  end

  def create
    @upvote = Upvote.create(vote_params)
    @upvote.update(user_id: current_user.id)
    @upvote.blurt.update_approval
    redirect_to upvotes_path
  end

  def index
    @best_blurt = Blurt.best_blurt
    @blurts = Blurt.order(:approval => :desc)
    @vote_quantity = Upvote.where(blurt_id: @best_blurt.id).length

  end

  def show
  end

  private
  def vote_params
    params.require(:upvote).permit(:blurt_id, :show_id)
  end

end
