class TripsController < ApplicationController
  before_action :set_rider, only: [:index]
  before_action :set_trip_and_rider, except: [:index]
  before_action :ensure_logged_in, only: [:edit, :update, :create, new]
  before_action :ensure_logged_in, only: [:index, :show], unless: :json_format?

  def index
    respond_to do |format|
      format.html do
        @trips = @rider.trips
        render
      end
      format.json { render json: @rider.trips.all }
    end
  end

  def show
    respond_to do |format|
      format.html do
        render
      end
      format.json { render json: @trip }
    end
  end

  def edit
    render
  end

  def update
    @trip.update!(trip_params)

    redirect_to trip_path(@trip)
  end

  def new
  end

  def create
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :name)
  end

  def set_rider
    @rider = Rider.find_by(user_id: params[:rider_id]) || current_user
  end

  def set_trip_and_rider
    @trip = Trip.find params[:id]
    @rider = @trip.rider
  end
end
