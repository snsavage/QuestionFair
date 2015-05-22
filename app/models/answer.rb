class Answer < ActiveRecord::Base

  include PublicActivity::Common
  
  belongs_to :user, touch: true
  belongs_to :question, touch: true, counter_cache: true

  has_many :answer_votes

  validates :question, presence: true
  validates :answer, presence: true
  validates :answer, length: { maximum: 500 } 
  validates :answer, uniqueness: {scope: :question_id, 
    message: "cannot be provided more than once, but you can vote on an answer that you like."}
  # validate :ensure_only_one_answer 

  def voter_list
    User.select("id","nickname").find(self.answer_votes.pluck(:user_id))
  end

  def best_answer?
    best?
  end
end
