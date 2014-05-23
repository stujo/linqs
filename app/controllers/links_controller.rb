class LinksController < ApplicationController
  def main
  end

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(links_params)
    if @link.save
      redirect_to link_path(@link)
    else
      flash[:errors] = @link.errors.full_messages
    end
  end

  def show
    @link = Link.find(params[:id])
    @title = @link.title
    @url = @link.url
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(links_params)
      redirect_to link_path(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :edit
    end
  end

    def destroy
      @link = Link.find(params[:id])
      @link.destroy
      redirect_to root_path
    end

    private
    def links_params
      params.require(:link).permit(:title, :url)
    end
  end
