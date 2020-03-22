require 'rails_helper'

describe "Project API", type: :request do

  context "Good Params" do 

    let(:project) { Project::Create.(params: {name: "Test", tags: {'first' => '1'}, type: 1}) }

    it "shows all Projects" do 
      project = Project::Create.(params: {name: "Test", tags: {'first' => '1'}, type: 1}) 
      project1 = Project::Create.(params: {name: "Test1", tags: {'second' => '2'}, type: 0}) 
      get "/api/v1/projects"
      expect(response.status).to eq 200
      expect(json.size).to eq 2
      expect(json[0]['name']).to eq 'Test'
      expect(json[0]['type']).to eq 'b'
      expect(json[1]['name']).to eq 'Test1'
      expect(json[1]['type']).to eq 'a'
    end

    it "Shows specific project" do
      get "/api/v1/projects/#{project["model"].id}"
      expect(response.status).to eq 200
      expect(json["name"]).to eq 'Test'
      expect(json["tags"]).to be_an_instance_of(Hash)
    end

    it "Creates project" do 
      post "/api/v1/projects", params: { name: "Test", tags: {'1' => '2'}, type: 0  }, as: :json
      expect(response.status).to eq 201
      expect(json["name"]).to eq 'Test'
      expect(json["type"]).to eq "a"
    end

    it "Updates project" do 
      put "/api/v1/projects/#{project["model"].id}", params: { name: "Updated" }
      expect(response.status).to eq 200
      expect(json["name"]).to eq 'Updated'
    end
    
    it "Destroy project" do
      delete "/api/v1/projects/#{project["model"].id}"
      expect(response.status).to eq 204 
    end
  end

  context "Bad params" do 
    it "Shows error when project doesn't exist on SHOW" do 
      get "/api/v1/projects/23"
      expect(response.status).to eq 200
      expect(json).to eq(nil)
    end

    it "Shows error when project doesn't exist on UPDATE" do 
      put "/api/v1/projects/23", params: { name: "Updated1"}
      expect(response.status).to eq 404
      expect(json["error"]).to eq "Couldn't find Project with 'id'=23"
    end

    it "Shows error when project doesn't exist on DELETE" do 
      delete "/api/v1/projects/23"
      expect(response.status).to eq 404
      expect(json["error"]).to eq "Couldn't find Project with 'id'=23"
    end

    it "Shows error if name doesn't exist in params" do 
      post "/api/v1/projects", params: { tags: {'1' => '2'}, type: 0  }, as: :json
      expect(response.status).to eq 201
      expect(json["name"]).to eq ["can't be blank"]
    end

    it "Shows error if name is not uniqe" do 
      project = Project::Create.(params: {name: "Test", tags: {'first' => '1'}, type: 1})
      post "/api/v1/projects", params: { name: "Test", tags: {'1' => '2'}, type: 0  }, as: :json
      expect(json["name"]).to eq ["has already been taken"]
    end
  end
end