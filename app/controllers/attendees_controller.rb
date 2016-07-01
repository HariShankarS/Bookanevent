class AttendeesController < ApplicationController

	def new
	@attendee = Attendee.new
	@attendee.name   = current_user.name
	@attendee.gender = current_user.gender
	end

	def index
	@attendees = Attendee.all
	end

	def create
	@attendee = Attendee.new(attendee_params)
	@attendee.save	
	end

	private
	def attendee_params
	params.require(:attendee).permit(:name , :gender)
end
