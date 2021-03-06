class Friendship < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_id }

  scope :unconfirmed, -> { 
    where(user_confirmed: true, friend_confirmed: false) }

  scope :confirmation_requested, -> { 
    where(user_confirmed: false, friend_confirmed: true) }

  scope :confirmed, -> { 
    where(user_confirmed: true, friend_confirmed: true) }

  scope :find_inverse, ->(user_id, friend_id) { 
    where(user_id: friend_id, friend_id: user_id).first }

  def nicknames
    self.user.nickname.try(:nickname)
  end

end
