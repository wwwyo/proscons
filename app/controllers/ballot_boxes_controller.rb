class BallotBoxesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :room_name, except: :top, if: :user_signed_in?
  before_action :search

  def top
    redirect_to action: :index if user_signed_in?
  end
  
  def index
    @ballot_boxes = BallotBox.includes(ballot_tags: :tag).joins(:ballot_tags).group('ballot_boxes.id').preload(:ballot_tags).where(ballot_tags: {tag_id: @search.result.ids}).order(created_at: :desc)
  end

  def popular
    @ballot_boxes =  BallotBox.includes(ballot_tags: :tag).joins(:votes).group('ballot_boxes.id').order(Arel.sql('count(ballot_boxes.id) desc'))
  end

  def new
    @ballot_form = BallotForm.new
  end

  def create
    @ballot_form = BallotForm.new(ballot_params)
    if @ballot_form.valid?
      ballot_box_id = @ballot_form.save
      if tags = tags_params
        tags.each do |tag, name| 
          tag_add = Tag.where(name: name).first_or_create
          BallotTag.create(ballot_box_id: ballot_box_id, tag_id: tag_add.id)
        end
      end
      redirect_to ballot_boxes_path
    else
      render :new
    end
  end

  def show
    @ballot_box = BallotBox.find(params[:id])
    @tags = BallotTag.where(ballot_box_id: @ballot_box.id).includes(:tag)
    @vote = Vote.new
    @votes = @ballot_box.votes
  end

  def edit
    @ballot_box = BallotBox.find(params[:id])
    @tags = BallotTag.where(ballot_box_id: @ballot_box.id).includes(:tag)
    unless @ballot_box.user_id == current_user.id
      redirect_to ballot_box_path
    end
  end

  def update
    ballot_box = BallotBox.find(params[:id])
    unless ballot_box.user_id == current_user.id
      redirect_to ballot_box_path
    end
  end

  def destroy
    ballot_box = BallotBox.find(params[:id])
    unless ballot_box.user_id == current_user.id
      redirect_to ballot_box_path
    else
      if ballot_box.destroy
        redirect_to ballot_boxes_path
      else
        redirect_to ballot_box_path
      end
    end
  end

  private
  def room_name
    @user_rooms = current_user.user_rooms.includes(:room).order(created_at: :desc)
  end

  def search
    @search = Tag.ransack(params[:q])
  end

  def ballot_params
    params.require(:ballot_form).permit(:question, :detail, :name).merge(user_id: current_user.id)
  end

  def tags_params
    params[:names]
  end
end

