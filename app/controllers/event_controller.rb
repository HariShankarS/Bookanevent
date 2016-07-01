class EventController < ApplicationController
  before_action :authenticate_user!, :only => [:attend]
  def new
  	@event = Event.new
  end

  def index
  	@events = Event.all.order("created_at ASC")
  end

  def show
  	@event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def create
  	@event = Event.new(event_params)
  	@event.save
  	redirect_to event_index_path
  end

  def attend
    @event = Event.find(params[:id])   
    @attendee = @event.attendees.new
    @attendee.user_id = current_user.id
    @attendee.save
    redirect_to show_id_path(@event)
  end

  def unattend
    @event = Event.find(params[:id])   
    @unattend = current_user.attendees.where(event_id: @event.id).first
    @unattend.destroy
    redirect_to show_id_path(@event)
  end

  def price
    
  end


  private

  def event_params
  params.require(:event).permit(:name, :time, :venue, :description ,:ticketcost)
  end
end
