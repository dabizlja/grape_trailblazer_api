require 'rails_helper'

describe "Project API", type: :request do
 
  let!(:project) { Project.create!(name: "Test", tags: {'first' => '1'}, type: 1) }
  let!(:project1) { Project.create!(name: "Test1", tags: {'second' => '2'}, type: 0) }

  context "Good Params" do 
    it "shows all Projects" do 
      get "/api/v1/projects"
      expect(response.status).to eq 200
      expect(json.size).to eq 2
      expect(json[0]['name']).to eq 'Test'
      expect(json[0]['type']).to eq 'b'
      expect(json[1]['name']).to eq 'Test1'
      expect(json[1]['type']).to eq 'a'
    end

    it "Shows specific project" do 
      get "/api/v1/projects/#{project.id}"
      expect(response.status).to eq 200
      expect(json["name"]).to eq 'Test'
      expect(json["tags"]).to be_an_instance_of(Hash)
    end

    it "Creates project" do 
      post "/api/v1/projects", params: { name: "Test", tags: {'1' => '2'}, type: 0  }
      expect(response.status).to eq 201
      expect(json["name"]).to eq 'Test'
      expect(json["type"]).to eq "a"
    end

    it "Updates project" do 
      put "/api/v1/projects/#{project.id}", params: { name: "Updated" }
      expect(response.status).to eq 200
      expect(json["name"]).to eq 'Updated'
    end
    
    it "Destroy project" do
      delete "/api/v1/projects/#{project.id}"
      expect(response.status).to eq(200) 
    end
  end

  context "Bad params" do 
    it "Shows error when project doesn't exist on SHOW" do 
      get "/api/v1/projects/23"
      expect(response.status).to eq 404
      expect(json["error"]).to eq "Couldn't find Project with 'id'=23"
    end

    it "Shows error when project doesn't exist on UPDATE" do 
      put "/api/v1/projects/23"
      expect(response.status).to eq 404
      expect(json["error"]).to eq "Couldn't find Project with 'id'=23"
    end

    it "Shows error when project doesn't exist on DELETE" do 
      delete "/api/v1/projects/23"
      expect(response.status).to eq 404
      expect(json["error"]).to eq "Couldn't find Project with 'id'=23"
    end
  end
end