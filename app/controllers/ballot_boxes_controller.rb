class BallotBoxesController < ApplicationController
  def top
  end
  
  def index
    @ballot_boxes = BallotBox.includes(ballot_tags: :tag).order(created_at: :desc)
  end

  def new
    @ballot_form = BallotForm.new
  end

  def create
    @ballot_form = BallotForm.new(ballot_params)
    if @ballot_form.valid?
      @ballot_form.save
      redirect_to ballot_boxes_path
    else
      render :new
    end
  end

  def show
  end

  private
  
  def ballot_params
    params.require(:ballot_form).permit(:question, :detail, :name).merge(user_id: current_user.id)
  end
end
