class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
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
    @tag = Tag.find(params[:id])
    @name = @tag.name
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tags_params)
      redirect_to tag_path(@tag)
    else
      flash[:errors] = @tag.errors.full_messages
      render :edit
    end
  end

    def destroy
      @tag = Tag.find(params[:id])
      @tag.destroy
      redirect_to root_path
    end

    private
    def tags_params
      params.require(:tag).permit(:name)
    end
end
