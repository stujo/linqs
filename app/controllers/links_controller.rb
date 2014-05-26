class LinksController < ApplicationController

  before_action :find_link , only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]

  before_filter :authenticate_user!

  def main
  end

# will eventually display all public links via ajax get request
  def index

        links = Link.all
        @links = []

        links.each do |link|  
          link_tags = []
          link.tags.each do |tag|
            link_tags.push(tag.name)
          end
          if link_tags.include?("private") == false
            @links.push(link)
          end
        end
  end

# should build new tags associated with the new link - is this working??
  def new
    @link = Link.new
    @link_tag = @link.link_tags.build
    @link_tag.build_tag
  end

# will send new instance of link via ajax post to db and retrieves json for same link to display on page without reloading
  def create
    @link = Link.new(links_params)
    @link[:user_id] = current_user.id
    if @link.save

      redirect_to link_path(@link)
    else
      flash[:errors] = @link.errors.full_messages
    end

  end

# shows details of a single link, including all tags assoc'd with it
  def show
    @title = @link.title
    @url = @link.url
  end

# loads link and assoc'd tags to edit
  def edit
    @link_tag = @link.link_tags.build
    @link_tag.build_tag

    @link = Link.find(params[:id])
  end

 # will send updated link attributes via ajax post 
  def update
    if @link.update(links_params)
      redirect_to link_path(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :edit
    end
  end

    def destroy
      @link.destroy
      redirect_to root_path
    end


    private
    def find_link
      @link = Link.find(params[:id])
    end
    def links_params
      params.require(:link).permit(:title, :url, link_tags_attributes: [tag_attributes: [:name] ])
    end
  end
