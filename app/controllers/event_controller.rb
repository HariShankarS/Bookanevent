class EventController < ApplicationController
  before_action :authenticate_user!, :only => [:attend, :unattend]

  def index
  	@events = Event.all.order("created_at ASC")
  end

  def show
  	@event = Event.find_by_id(params[:id])
    if @event.present?
      @attendees = @event.attendees
    else
      flash[:error] = "The Event is not present anymore"
      redirect_to event_index_path
    end
  end

  def attend
    @event = Event.find_by_id(params[:id])   
    
    if @event.present?
      @attendee = @event.attendees.new(user: current_user)
      if @attendee.save
        flash[:success] = "You are attending this event"
      else
        flash[:error] = @attendee.errors.full_messages.join(", ")
      end
      redirect_to show_id_path(@event)
    else
      flash[:errors] = "Event you are looking for doesnt seem to present anymore"
      redirect_to event_index_path
    end
  end

  def unattend
    @event = Event.find_by_id(params[:id])
    if @event.present?
      @unattend = current_user.attendees.where(event: @event).first
      if @unattend.present?
        @unattend.destroy
        flash[:success] = "You are not attending this event anymore"
      else
        flash[:error] = "You doesnt seem to be attending this event, please try again"
      end
      redirect_to show_id_path(@event)
    else
      flash[:errors] = "Event you are looking for doesnt seem to present anymore"
      redirect_to event_index_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :time, :venue, :description ,:ticketcost)
  end
end
