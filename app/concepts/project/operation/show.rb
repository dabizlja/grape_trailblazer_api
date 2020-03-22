class Project::Show < Trailblazer::Operation
  step Model(Project, :find_by)
end