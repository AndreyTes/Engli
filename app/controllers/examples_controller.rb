class ExamplesController < ApplicationController
  before_action :phrase
  
  def create
    @example = @phrase.examples.new(example_params)
    if @example.save
      flash[:notice] = 'Example has been created'
    else
      flash[:danger] = @example.errors.full_messages.to_sentence
    end
    redirect_to phrase_path(@phrase)
  end
  
  def destroy
    @phrase.examples.find(params[:id]).destroy
    flash[:notice] = 'Example has been deleted!'
    redirect_to phrase_path(@phrase)
  end

private

  def example_params
   params.require(:example).permit(:example, :user_id)
  end

  def phrase
    @phrase = Phrase.friendly.find(params[:phrase_id])
  end

  def check_user
    unless @phrase.author? current_user
      flash[:danger] = 'You don\'t author of example, go away!'
      redirect_to(@phrase.user)
    end
  end
end
