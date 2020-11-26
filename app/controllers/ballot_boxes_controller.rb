class BallotBoxesController < ApplicationController
  include Share

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :share, except: :top
  before_action :summary_ballot_box, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]

  def top
    redirect_to action: :index if user_signed_in?
  end

  def index
    @ballot_boxes = BallotBox.search(@search).includes(ballot_tags: :tag).order(created_at: :desc)
  end

  def popular
    vote = Vote.group(:ballot_box_id).order('count(ballot_box_id) desc').pluck(:ballot_box_id)
    @ballot_boxes = BallotBox.search(@search).includes(ballot_tags: :tag).order(['field(`ballot_boxes`.`id`, ?)', vote])
  end

  def new
    @ballot_form = BallotForm.new
  end

  def create
    @ballot_form = BallotForm.new(ballot_params)
    if @ballot_form.valid?
      ballot_box_id = @ballot_form.save
      Tag.add_tag(tags_params, ballot_box_id) if tags_params.present?
      redirect_to ballot_boxes_path
    else
      render :new
    end
  end

  def show
    @vote = Vote.new
    @tags = @ballot_box.ballot_tags.includes(:tag)
    @votes = @ballot_box.votes
  end

  def edit
  end

  def update
    if @ballot_box.update(ballot_update_params)
      redirect_to ballot_box_path(@ballot_box)
    else
      render :edit, flash: {alert: "編集できませんでした"}
    end
  end

  def destroy
    if @ballot_box.destroy
      redirect_to ballot_boxes_path
    else
      @votes = @ballot_box.votes
      render :show, flash: {alert: "削除できませんでした"}
    end
  end

  private

  def share
    share_content
  end

  def ballot_params
    params.require(:ballot_form).permit(:question, :detail, :name).merge(user_id: current_user.id)
  end

  def tags_params
    params[:names]
  end

  def ballot_update_params
    params.require(:ballot_box).permit(:supplement)
  end

  def summary_ballot_box
    @ballot_box = BallotBox.find(params[:id])
  end

  def user_check
    if @ballot_box.user_id != current_user.id
      return redirect_to ballot_box_path(@ballot_box)
    end
    @tags = @ballot_box.ballot_tags.includes(:tag)
  end
end
