class PhrasesController < ApplicationController
  before_action :self_like, only: [:vote]
  before_action :phrase , only: [:edit]
  
  def index
    @phrases = Phrase.includes(:user).order(created_at: "desc").paginate(page: params[:page])
  end
    
  def new
    @phrase = Phrase.new
    @phrase.examples.new(user_id: current_user.id)
  end
  
  def show
    @examples = phrase.examples.includes(:user).paginate(page: params[:page])
    @example = phrase.examples.build(user_id: current_user.id)
  end

  def edit
  end
 
  def create
    @phrase = current_user.phrases.new(phrase_params)
    if @phrase.save
      flash[:notice] = 'Phrase has been created'
      redirect_to :root_path
    else   
      flash[:danger] = 'Phrase can`t be created'
      render :new 
    end 
  end
  
  def update
    if phrase.update(phrase_params)
      flash[:notice] = 'Phrase has been updated!'
      redirect_to user_path(@phrase.user)
    else
      flash[:danger] = 'Phrase can`t be updated'
      render :edit
    end
  end

  def destroy
    phrase.destroy
    flash[:notice] = 'Phrase has been deleted'
    redirect_to user_path(@phrase.user)
  end

  def vote
    if params[:vote] == 'up'
      phrase.liked_by current_user
    else
      phrase.downvote_from current_user
    end
    redirect_to(:root_path)

    if phrase.vote_registered?
      phrase.calc_carma(params[:vote], current_user)
      message = params[:vote] == 'up' ? 'Liked your phrase' : 'Disliked your phrase'
      phrase.create_activity key: message, owner: current_user, recipient: phrase.user
      flash[:notice] = 'Thanks for your vote'
    else
      flash[:danger] = 'You already voted that post'
    end
  end

  private
  
  def phrase_params
    params.require(:phrase).permit(:phrase, :translation, :category, examples_attributes: [:example, :user_id, :_destroy])
  end  
  
  def phrase
    @phrase ||= Phrase.friendly.find(params[:id])
  end
  
  def self_like
    if phrase.user == current_user
      flash[:danger] = 'You cant like/dislike yourself phrase'
      redirect_to(:root_path)
    end
  end  
end
