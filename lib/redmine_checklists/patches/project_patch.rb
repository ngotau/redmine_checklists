require_dependency 'project'

module RedmineChecklists
  module Patches

    module ProjectPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          
          attr_accessor :checklist_tracker_id
          
          has_many :project_checklists,:class_name => "ProjectChecklist", :dependent => :destroy, :inverse_of => :project,
                   :order => 'position',
                   :conditions => proc { "tracker_id = #{self.checklist_tracker_id}" }

          accepts_nested_attributes_for :project_checklists, :allow_destroy => true, :reject_if => :all_blank

          safe_attributes 'project_checklists_attributes',
            :if => lambda {|project, user| (user.allowed_to?(:create_checklists, project))}

        end


      end

    end

  end
end


unless Project.included_modules.include?(RedmineChecklists::Patches::ProjectPatch)
  Project.send(:include, RedmineChecklists::Patches::ProjectPatch)
end
