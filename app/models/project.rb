class Project < ApplicationRecord
  # Column type should be renamed as ActiveRecord is using that for STI.
  self.inheritance_column = :foo
  serialize :tags, JSON
  enum type: [:a, :b, :c]
end
