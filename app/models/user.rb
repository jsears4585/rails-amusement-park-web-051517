class User < ActiveRecord::Base

  has_secure_password

  has_many :rides
  has_many :attractions, through: :rides

  def mood
    if self.nausea && self.happiness
      rating = self.nausea - self.happiness
      rating > 0 ? "sad" : "happy"
    end
  end

  def num_of_rides
    self.attractions.count
  end

end
