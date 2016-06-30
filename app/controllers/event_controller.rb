class EventController < ApplicationController
  def new
  	@event = Event.new
  end

  def index
  	@events = Event.all
  end

  def show
  	@event = Event.find(params[:id])
  end

  def create
  	@event = Event.new(event_params)
  	@event.save
  	redirect_to event_index_path
  end

  private

  def event_params
  params.require(:event).permit(:name, :time, :venue, :description)
  end
end
