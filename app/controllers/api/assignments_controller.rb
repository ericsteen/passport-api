  class API::AssignmentsController < API::ApplicationController
  before_action :set_assignment, only: [:show, :update, :destroy]

  # POST /assignments
  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      head :created
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end


  private
    # Only allow a trusted parameter "white list" through.
    def assignment_params
      params.require(:assignment).permit(:timeslot_id, :boat_id)
    end
end
