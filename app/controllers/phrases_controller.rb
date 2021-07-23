class PhrasesController < ApplicationController
  before_action :phrase , only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  
  def index
    @phrases = Phrase.includes(:user).paginate(page: params[:page],per_page: 10)
  end
    
  def new
    @phrase = Phrase.new
    @phrase.examples.build(user_id: current_user.id)
  end
  
  def show
    @examples = @phrase.examples.includes(:user).paginate(page: params[:page],per_page: 10)
    @example = @phrase.examples.build(user_id: current_user.id)
  end

  def edit
  end
 
  def create
    @phrase = current_user.phrases.new(phrase_params)
      if @phrase.save
        flash[:notice] = 'Phrase has been created'
        redirect_to :root_path
      else   
        flash[:denger] = @phrase.errors.full_message.to_sentence
        render :new 
      end 
  end
  
  def update
    if @phrase.update(phrase_params)
      flash[:notice] = 'Phrase has been updated!'
      redirect_to user_path(@phrase.user)
    else
      flash[:danger] = @phrase.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @phrase.destroy
    flash[:notice] = 'Phrase has been deleted!'
    redirect_to user_path(@phrase.user)
  end

  private
  
  def  phrase_params
    params.require(:phrase).permit(:phrase, :translation, :category, examples_attributes: [ :example, :user_id, :_destroy ] )
  end  
  
  def phrase
    @phrase = Phrase.friendly.find(params[:id])
  end
  
  def check_user
    unless @phrase.author? current_user
      flash[:danger] = 'You don\'t author of phrase, go away!'
      redirect_to(@phrase.user)
    end
  end
  
end
