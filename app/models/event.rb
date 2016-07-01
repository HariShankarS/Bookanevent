class Event < ActiveRecord::Base
	has_many :attendees
	has_many :users, through: :attendees


  def price(current_user)
  	if current_user.nil?
  		return ticketcost.to_i
  	else
    	if current_user.gender == "Male"
     		return  ticketcost.to_i
    	else	
      		return 0.95*ticketcost.to_i
    	end
  	end
  end
end
