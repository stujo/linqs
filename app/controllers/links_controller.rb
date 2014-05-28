class LinksController < ApplicationController

  before_action :find_link , only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]


  # will eventually display all public links via ajax get request

def index
  # makes a new instance of Link
    @link = Link.new
    links = Link.all.order(:created_at).reverse_order

  #creates an empty array for public and private links
    @links = []
    @linksprivate = []

  #accesses the tag
    links.each do |link|  
  #link_tags is the array where the tags are pushed into
    link_tags = []
    link.tags.each do |tag|
    link_tags.push(tag.name)
      end

      #pushes everything that is "not private" into the array
      if !link_tags.include?("private")
        @links.push(link)
      #if private && the creator of link  does not equal current user - do not show
      elsif current_user != nil
          if link_tags.include?("private") == true && link.user_id == current_user.id
            @linksprivate.push(link)
          end
      else
          flash[:errors] = "You're not logged in sucka!!!"
      end 
    end
        respond_to do |format|
          format.html
          format.json { render :json => {:links => @links.as_json}}
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
    # @link_tag = @link.link_tags.build
    # @link_tag.build_tag
    @link[:user_id] = current_user.id
    # @tag[:user_id] = current_user.id


    #@link.tags.last[:user_id] = current_user.id
    # if @link.save

    #   redirect_to link_path(@link)
    # else
    #   flash[:errors] = @link.errors.full_messages
    # @link[:user_id] = current_user.id
    respond_to do |format|
      if @link.save
        format.json { render :json => @link, :include=> :tags, status: :created}
      else
        format.json { render json: @link.errors, status: :unprocessable_entity}
      end
    end
    @tag = @link.tags.last
    @tag[:user_id] = current_user.id
    @tag.save
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
      params.require(:link).permit(:title, :url, :link_tags_attributes => [:tag_attributes =>[:name]])
    end
  end
