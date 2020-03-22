module V1
  class Projects < Grape::API
    include V1::Default

    resources :projects do 
      desc "List all projects"
      get do
        Project::Index.()["model"]
      end

      desc "Return specific project"
      get ":id" do 
        Project::Show.(params: params)["model"]
      end

      desc "Create project"
      post do
        result = Project::Create.(params: params)
        result.success? ? result["model"] : result["result.contract.default"].errors.messages
      end

      desc "Update project"
      put ":id" do
        Project::Update.(params: params)["model"]
      end

      desc "Delete project"
      delete ":id" do 
        Project::Delete.(params: params)["model"]
      end
    end
  end
end
