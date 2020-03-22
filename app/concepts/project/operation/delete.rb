class Project::Delete < Trailblazer::Operation
  step :model!

  def model!(options, params:, **)
    project = Project.find(params[:id])
    project.destroy
  end
end