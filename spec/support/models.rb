class Book < ActiveRecord::Base
end

if defined?(CompositePrimaryKeys)
  class Registration < ActiveRecord::Base
    self.primary_keys = :user_id, :course_id
  end
end
