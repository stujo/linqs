class LinksController < ApplicationController
  def main
  end

  def index
    @link = Link.new
    @links = Link.all
    respond_to do |format|
      format.html
      format.json { render :json => {:links => @links.as_json(except: [:id, :created_at, :updated_at])}}
    end
  end

  def new
    @link = Link.new
    @link_tag = @link.link_tags.build
    @link_tag.build_tag
  end

  def create
    @link = Link.new(links_params)
    respond_to do |format|
      if @link.save
        format.json { render :json => {:link => @link.as_json(except: [:id, :created_at, :updated_at])}, status: :created}
      else
      flash[:errors] = @link.errors.full_messages
      end
    end
  end

  def show
    @link = Link.find(params[:id])
    @title = @link.title
    @url = @link.url
  end

  def edit
    @link = Link.find(params[:id])
    @link_tag = @link.link_tags.build
    @link_tag.build_tag
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
      params.require(:link).permit(:title, :url, link_tags_attributes: [tags_attributes: [:name] ])
    end
  end
