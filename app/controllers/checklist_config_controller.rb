class ChecklistConfigController < ApplicationController
  unloadable

  helper ChecklistsHelper
  
  accept_api_auth :index, :update, :destroy, :create, :show
  
  def index
    @project_checklists = @project.project_checklists
    respond_to do |format|
      format.api
    end
  end
  
  def show
    respond_to do |format|
      format.api
    end
  end
  
  def destroy
    @project_checklist_item.destroy
    respond_to do |format|
      format.api {render_api_ok}
    end
  end
  
  def create
    
  end
  
  def update
    respond_to do |format|
      format.api {
        if @project_checklist_item.update_attributes(params[:project_checklist])
          render_api_ok
        else
          render_validation_errors(@project_checklist_item)
        end
      }
    end
  
    redirect_to :controller => 'projects',:action => "settings", :id => @project, :tab => 'checklist'
  end
  
  private
  def find_project_checklist_item
    @project_checklist_item = ProjectChecklist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render_404
  end
end
