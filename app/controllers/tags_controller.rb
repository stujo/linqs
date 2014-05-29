class TagsController < ApplicationController
<<<<<<< HEAD
  before_action :find_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all.order(:name)
    respond_to do |format|
      format.html
      format.json { render :json => {:tags => @tags.as_json}}
    end
=======
 before_action :find_tag, only: [:show, :edit, :update, :destroy]
 validates :name , presence: true
 
  def index
    @tags = Tag.search(params[:search]).paginate(:per_page => 20, :page => params[:page])
>>>>>>> 48290b8528a11f42af859fd758027a4bd5243175
  end

  def new
    @tag = Tag.new
    @tag.link_tags.build
  end

  def create
    @tag = Tag.new(tags_params)
    if @tag.save
      redirect_to tag_path(@tag)
    else
      flash[:errors] = @tag.errors.full_messages
    end
  end
  

  def show
    # @tag = Tag.find(params[:id])
  end

  def edit
    # find all link_ids assoc'd with tag_id in link_tags
    @links = []
    @tag.link_tags.find_by(tag_id: @tag.id).each do |link|
      @links.push(link)
    end
  end

  def update
    if @tag.update(tags_params)
      redirect_to tag_path(@tag)
    else
      flash[:errors] = @tag.errors.full_messages
      render :edit
    end
  end
  


  def destroy
    #@tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to root_path
  end

  private
  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tags_params
    params.require(:tag).permit(:name)
  end
end
