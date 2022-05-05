class ApplicationRecord < ActiveRecord::Base
  include CreateUuid
  self.abstract_class = true
end
