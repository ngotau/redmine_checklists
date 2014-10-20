class ChecklistConfigController < ApplicationController
  unloadable

  helper ChecklistsHelper

  def show
    respond_to do |format|
      format.api
    end
  end

  def create
    
  end
  
  def update
    redirect_to :controller => 'projects',:action => "settings", :id => @project, :tab => 'checklist'
  end

end
