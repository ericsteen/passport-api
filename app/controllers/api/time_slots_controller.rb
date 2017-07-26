class API::TimeSlotsController < API::ApplicationController
  before_action :set_time_slot, only: [:show, :update, :destroy]

  # GET /time_slots
  def index

    date = params[:date].to_datetime
    date_range = date.beginning_of_day..date.end_of_day
    @time_slots = TimeSlot.where(start_time: date_range).map(&:to_builder).map(&:target!)

    render json: @time_slots
  end

  # POST /time_slots
  def create

    @time_slot = TimeSlot.new(time_slot_params)
    @time_slot.start_time = DateTime.strptime(time_slot_params[:start_time],'%s')

    if @time_slot.save
      render json: @time_slot, status: :created
    else
      render json: @time_slot.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def time_slot_params
      params.require(:timeslot).permit(:start_time, :duration)
    end
end
