class ExamplesController < ApplicationController
  before_action :self_like, only: [:vote]
  
  def create
    @example = phrase.examples.new(example_params)
    if @example.save
      flash[:notice] = 'Example has been created'
    else
      flash[:danger] = 'Example can`t be created'
    end
    redirect_to phrase_path(@phrase)
  end
  
  def destroy
    phrase.examples.find(params[:id]).destroy
    flash[:notice] = 'Example has been deleted'
    redirect_to phrase_path(@phrase)
  end

  def vote
    @example = phrase.examples.find(params[:example_id])
    if params[:vote] == 'up'
      @example.liked_by current_user
    else
      @example.downvote_from current_user
    end
    redirect_to phrase_path(@phrase)
    
    if @example.vote_registered?
      @example.calc_carma(params[:vote], current_user)
      message = params[:vote] == 'up' ? 'Liked your example' : 'Disliked your example'
      @example.create_activity key: message, owner: current_user, recipient: @example.user
      flash[:notice] = 'Thanks for your vote'
    else
      flash[:danger] = 'You already voted that post'
    end
  end

private

  def example_params
   params.require(:example).permit(:example, :user_id)
  end

  def phrase
    @phrase ||= Phrase.friendly.find(params[:phrase_id])
  end

  def self_like
    if phrase.examples.find(params[:example_id]).user == current_user
      flash[:danger] = 'You cant like/dislike yourself example'
      redirect_to phrase_path(@phrase)
    end
  end  
end
