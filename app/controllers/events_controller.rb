class EventsController < ApplicationController

  before_filter :require_user, only: [:create, :new]
  before_filter :set_event, only: [:show, :edit, :update]

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
    @rsvp = Rsvp.new
    @comment = Comment.new
  end

  def edit
    @announcement = Announcement.new
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event was successfully updated"
      redirect_to event_path(@event)
    else
      flash[:danger] = "There was an error"
      render :edit
    end
  end
  
  private

  def event_params
    params.require(:event).permit! 
  end

  def set_event
    @event = Event.find_by(slug: params[:id]) 
  end

end