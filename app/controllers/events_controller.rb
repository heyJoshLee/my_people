class EventsController < ApplicationController

  before_filter :require_user, only: [:create, :new]

  def index
    @events = Event.all
    
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    if @event.save
      flash[:success] = "Your event has been created"
      redirect_to event_path(@event)
    else
      flash.now[:danger] = "There was an error and your event was not created."
      render :new
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    redirect_to event_not_found_path unless @event
  end

  private

  def event_params
    params.require(:event).permit!
    
  end

end