class LinksController < ApplicationController

  before_action :find_link , only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    # makes a new instance of Link
    @link = Link.new
    links = Link.search_for(params[:q]).order(:upvotes).reverse_order

    both = separate_public_and_private(links)
    link_pub = both.first
    link_priv = both.last

    respond_to do |format|
      format.html
      format.json { render :json => {:links => link_pub.as_json}}
    end
  end
  

  # will eventually display all public links via ajax get request
  def sort_by_title
    @links = Link.all.order(:title)
    both = separate_public_and_private(links)
    link_pub = both.first
    link_priv = both.last
    respond_to do |format|
      format.html
      format.json { render :json => {:links => link_pub.as_json}}
    end
  end


  def separate_public_and_private(links)
    #creates an empty array for public and private links
    @links = []
    @linksprivate = []

    # accesses the tag
    links.each do |link|
      #link_tags is the array where the tags are pushed into
      link_tags = []
      link.tags.each do |tag|
        link_tags.push(tag.name)
      end

      #pushes everything that is "not private" into the array
      if !link_tags.include?("private")
        @links.push(link)
        # if private && the creator of link  does not equal current user - do not show
      elsif current_user != nil
        if link_tags.include?("private") == true && link.user_id == current_user.id
          @linksprivate.push(link)
        end
      else
        flash[:errors] = "You're not logged in sucka!!!"
      end
    end
    return [@links, @linksprivate]
  end

 

  # should build new tags associated with the new link - is this working??
  def new
    @link = Link.new
    @link_tag = @link.link_tags.build
    @link_tag.build_tag
  end

  # will send new instance of link via ajax post to db and retrieves json for same link to display on page without reloading
  def create
    # decide if link url already exists in db
    @potentialLink = Link.find_by(url: links_params[:url])
    @link = current_user.links.new(title: links_params[:title], url: links_params[:url])
    if @link.url.include?("http://")
      @link.save
    else
      @link.url.insert(0, "http://")
      @link.save
    end
    # Decide if tag is already in the database
    @potentialTag = Tag.find_by(name: links_params[:link_tags_attributes]["0"][:tag_attributes][:name])
    # if tag is already in db, create a new association btween new link and old tag
    if @potentialTag
      @link_tag = @link.link_tags.build(link_id: @link.id, tag_id: @potentialTag.id)
      @link_tag.save
      # otherwise, save new tag
    else
      @link.tags.build( name: links_params[:link_tags_attributes]["0"][:tag_attributes][:name])
      @link.save
    end
    respond_to do |format|
      if @link.save
        format.json { render :json => @link, :include=> :tags, status: :created}
      else
        format.json { render json: @link.errors, status: :unprocessable_entity}
      end
      # end
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

   def up_vote
    session[:return_to] ||= request.referer
    @link = Link.find(params[:id])
    @link.upvotes = @link.upvotes + 1 
     @link.save
   redirect_to session.delete(:return_to)
  end
  def down_vote
    session[:return_to] ||= request.referer
    @link  = Link.find(params[:id])
    @link.downvotes = @link.downvotes + 1
    @link.save
    redirect_to session.delete(:return_to)    
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
