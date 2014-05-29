class TagsController < ApplicationController
 before_action :find_tag, only: [:show, :edit, :update, :destroy]
 validates :name , presence: true
 
  def index
    @tags = Tag.search(params[:search]).paginate(:per_page => 20, :page => params[:page])
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
    @name = @tag.name
  end

  def edit
   # @tag = Tag.find(params[:id])
  end

  def update
    #@tag = Tag.find(params[:id])
    if @tag.update(tags_params)
      redirect_to tag_path(@tag)
    else
      flash[:errors] = @tag.errors.full_messages
      render :edit
    end
  end
  def search
      @tags = Tag.search (params[:search])
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
