class LinksController < ApplicationController
  before_action :find_link , only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  def main
  end

  def index

     # @links = Link.includes((:tag).where.not{:name => "private"})
       # @links = Link.all
       # Link.where(:link_id => Link.id, tag.name => " private")
         @links.each do |link|
         @tag = link.tags.where.not(name: "private")
       # :domains => { :name => "pauls-domain"}})
       
      end
  end

  def new
    @link = Link.new
    #@link.user = current_user
    @link_tag = @link.link_tags.build
    @link_tag.build_tag
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
    #@link = Link.find(params[:id])
    @title = @link.title
    @url = @link.url
  end

  def edit
   # @link = Link.find(params[:id])
    @link_tag = @link.link_tags.build
    @link_tag.build_tag
  end

  def update
    #@link = Link.find(params[:id])
    if @link.update(links_params)
      redirect_to link_path(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :edit
    end
  end

    def destroy
      #@link = Link.find(params[:id])
      @link.destroy
      redirect_to root_path
    end
 #  def destroy
   #   @link = Link.find(params[:id])
     
   #   if @link.user != current_user
   #     flash[:notice] = 'That link is not yours to destory'

   #     respond_to do |format|
   #       format.html { redirect_to :singin_path }
   #       format.json { head :no_content }
   #     end
   #   else
   #     @link.destroy

   #     respond_to do |format|
   #       format.html { redirect_to links_url }
   #       format.json { head :no_content }
   #     end
   #   end
 #   end

    private
    def find_link
      @link = Link.find(params[:id])
    end
    def links_params
      params.require(:link).permit(:title, :url, link_tags_attributes: [tag_attributes: [:name] ])
    end
  end
