class Base < Grape::API
  mount V1::Projects
end
