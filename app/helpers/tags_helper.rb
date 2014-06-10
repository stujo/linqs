module TagsHelper
  def check_tag_owner
    tag = current_user.tags.where(id: params[:id]).first
    if tag.nil?
      flash[:error] = "That's not your tag, sucka!!!."
      redirect_to tag_path(params[:id])
    end
  end
end
