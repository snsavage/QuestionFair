class Guest < User
  def persisted?
    false
  end

  def nickname
    "Guest User"
  end
end