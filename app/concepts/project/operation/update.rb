class Project::Update < Trailblazer::Operation
  step :model!
  step Contract::Build( constant: Project::Contract::Create )
  step Contract::Validate( )
  step Contract::Persist( )

  def model!(options, params:, **)
    options["model"] = Project.find(params[:id])
  end
end