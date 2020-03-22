module Project::Contract
  class Create < Reform::Form
    property :name
    property :tags
    property :type
    
    validates :name, presence: true
    validates_uniqueness_of :name
  end
end