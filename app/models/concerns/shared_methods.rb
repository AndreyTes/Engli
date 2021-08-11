module SharedMethods
  extend ActiveSupport::Concern
  def is_author?(user)
    self.user == user
  end
 
  def calc_carma(vote, current_user)
    current_user_carma_rating = current_user.carma
    another_user_carma_rating = self.user.carma
    another_user = self.user
    scores = vote == 'up' ? self.class::UPVOTE : self.class::DOWNVOTE
    another_user.update_attribute('carma', another_user_carma_rating + scores)
    current_user.update_attribute('carma', current_user_carma_rating + 1)
  end
end