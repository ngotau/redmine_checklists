class ChecklistConfigController < ApplicationController
  unloadable

  before_filter :find_project_by_project_id, :authorize
  
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
    tracker = params[:tracker]
    if params[:project] !=nil
      checklists = params[:project][:project_checklists_attributes] 
      checklists.each do |key,param|
        param[:tracker_id] = tracker
        @project.checklist_tracker_id = tracker
        @project.project_checklists_attributes = param
        @project.save
      end
    end
    redirect_to :controller => 'projects',:action => "settings", :id => @project, :tracker => tracker, :tab => 'checklist'
  end
  
  private
  def find_project_checklist_item
    @project_checklist_item = ProjectChecklist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render_404
  end
end
