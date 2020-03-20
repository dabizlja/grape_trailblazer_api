module V1
  class Projects < Grape::API
    include V1::Default

    resources :projects do 
      desc "List all projects"
      get do
        Project.all
      end

      desc "Return specific project"
      get ":id" do 
        project = Project.find(params[:id])
        present project
      end

      desc "Create project"
      post do
        Project.create!(name: params[:name], tags: params[:tags], type: params[:type].to_i) 
      end

      desc "Update project"
      put ":id" do 
        project = Project.find(params[:id])
        project.update(params)
        present project
      end

      desc "Delete project"
      delete ":id" do 
        project = Project.find(params[:id])
        project.destroy
      end
    end
  end
end
