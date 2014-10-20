class ProjectChecklist < ActiveRecord::Base
  unloadable
  
  belongs_to :project
  
  acts_as_list

  validates_presence_of :subject
  validates_presence_of :position
  validates_numericality_of :position
  
  def info
    "#{self.subject.strip}"
  end
end
