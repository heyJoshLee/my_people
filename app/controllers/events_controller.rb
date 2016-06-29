class EventsController < ApplicationController
  include ActiveModel::Dirty

  before_filter :require_user, only: [:create, :new]
  before_filter :set_event, only: [:edit, :update]


  def index
    @upcoming_events = Event.upcoming
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user

    if set_city_and_state
      @event.generate_map_image

      if @event.save
        flash[:success] = "Your event has been created"
        redirect_to event_path(@event)
      else
        flash.now[:danger] = "There was an error and your event was not created."
        render :new
      end
    else
      flash.now[:danger] = "Not a valid Zip code."
      render :new
    end
  end

  def show
    @event = EventDecorator.decorate(Event.find_by(slug: params[:id]))
    @rsvp = Rsvp.new
    @comment = Comment.new
  end

  def edit
    @announcement = Announcement.new
  end

  def update
    old_address = @event.formatted_address
    if @event.update(event_params)
      binding.pry
      unless old_address == @event.formatted_address
        @event.generate_map_image
        @event.save
      end
      flash[:success] = "Event was successfully updated"
      redirect_to event_path(@event)
    else
      flash[:danger] = "There was an error"
      render :edit
    end
  end
  
  private

  def set_city_and_state
    address_info = ZipCodes.identify(@event.zip_code)
    if address_info
      @event.city = address_info[:city]
      @event.state = address_info[:state_name]
    else
      false
    end
  end

  def event_params
    params.require(:event).permit! 
  end

  def set_event
    @event = Event.find_by(slug: params[:id]) 
  end

end