class Ride < ActiveRecord::Base

  belongs_to :user
  belongs_to :attraction

  def take_ride
    if !tall_enough? && !enough_tickets?
      "Sorry. " + tickets_fail + " " + height_fail
    elsif !tall_enough?
      "Sorry. " + height_fail
    elsif !enough_tickets?
      "Sorry. " + tickets_fail
    else
      start_ride
    end
  end

  def start_ride
    new_tickets = self.user.tickets - self.attraction.tickets
    new_happiness = self.user.happiness + self.attraction.happiness_rating
    new_nausea = self.user.nausea + self.attraction.nausea_rating
    self.user.update(
      tickets: new_tickets,
      happiness: new_happiness,
      nausea: new_nausea
    )
    "Thanks for riding the #{self.attraction.name}!"
  end

  def tall_enough?
    self.user.height >= self.attraction.min_height ? true : false
  end

  def enough_tickets?
    self.user.tickets >= self.attraction.tickets ? true : false
  end

  def tickets_fail
    "You do not have enough tickets to ride the #{attraction.name}."
  end

  def height_fail
    "You are not tall enough to ride the #{attraction.name}."
  end

end
