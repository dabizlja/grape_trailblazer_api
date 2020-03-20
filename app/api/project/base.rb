module Project
  class Base < Grape::API
    mount Project::V1::Projects
  end
end