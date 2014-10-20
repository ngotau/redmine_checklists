require_dependency 'projects_helper'

module CheckListProjectsHelperPatch
  def self.included base
    base.send :include, CheckListProjectsHelperMethods
    base.class_eval do
      alias_method_chain :project_settings_tabs, :checklist
    end
  end
end

module CheckListProjectsHelperMethods
  def project_settings_tabs_with_checklist
    tabs = project_settings_tabs_without_checklist
    tab = {
      :name => 'checklist',
      :controller => 'checklist_config', :action => :create,
      :partial => 'checklist_config/create', :label => :label_checklist_menu_main}
    if User.current.allowed_to?(tab, @project)
      tabs << tab
    end
    return tabs
  end
end

ProjectsHelper.send(:include, CheckListProjectsHelperPatch)
