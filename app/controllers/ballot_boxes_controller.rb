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
      ballot_box_id = @ballot_form.save
      tags = tags_params
      tags.each do |tag, name|
        tag_add = Tag.where(name: name).first_or_create
        BallotTag.create(ballot_box_id: ballot_box_id, tag_id: tag_add.id)
      end
      redirect_to ballot_boxes_path
    else
      render :new
    end
  end

  def show
    @ballot_box = BallotBox.find(params[:id])
    @tags = BallotTag.where(ballot_box_id: @ballot_box.id).includes(:tag)
  end

  def edit
    @ballot_box = BallotBox.find(params[:id])
    @tags = BallotTag.where(ballot_box_id: @ballot_box.id).includes(:tag)
  end

  def update
  end

  def destroy
    ballot_box = BallotBox.find(params[:id])
    if ballot_box.destroy
      redirect_to ballot_boxes_path
    else
      render :show
    end
  end

  private
  
  def ballot_params
    params.require(:ballot_form).permit(:question, :detail, :name).merge(user_id: current_user.id)
  end

  def tags_params
    params[:names]
  end
end
