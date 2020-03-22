require 'rails_helper'

describe Project::Create do 

  let(:valid_params) { { name: "Test", tags: {"first"=>"1"}, type: 0 } }
  let(:missing_params) { { tags: {"first"=>"1"}, type: 1} }
  
  it "should create new project" do 
    result = Project::Create.(params: valid_params)
    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].name).to eq("Test")
  end

  it "fails with missing input" do 
    result = Project::Create.(params: missing_params)
    expect(result).to be_failure
    expect(result["result.contract.default"].errors.messages).to eq({:name=>["can't be blank"]})
  end

  it "fails with same input" do 
    project = Project::Create.(params: { name: "Test", tags: {"first"=>"1"}, type: 0 })
    result = Project::Create.(params: valid_params)
    expect(result).to be_failure
    expect(result["result.contract.default"].errors.messages).to eq({:name=>["has already been taken"]})
  end
end
