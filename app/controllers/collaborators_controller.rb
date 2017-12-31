class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator_user = User.find(params[:collaborator_id])
    @wiki = Wiki.find(params[:wiki_id])

    if @wiki.collaborators.exists?(user_id: @collaborator_user.id)
      flash[:notice] = "#{@collaborator_user.email} is already a collaborator on this Wiki."
      redirect_to @wiki
    else
      @collaborator = Collaborator.new(user_id: @collaborator_user.id, wiki_id: @wiki.id)
      if @collaborator.save
        flash[:notice] = "#{@collaborator_user.email} has contributed to this Wiki."
        redirect_to @wiki
      else
        flash.now[:danger] = "An error occurred while adding #{@collaborator_user.email} as a collaborator. Try again"
        redirect_to @wiki
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    @collaborator_user = User.find(@collaborator.user_id)

    if @collaborator.destroy
      flash[:notice] = "#{@collaborator_user.email} is successfully removed from Collaborator list."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting the collaborator. Try again."
      redirect_to @wiki
    end
  end

# close class
end
