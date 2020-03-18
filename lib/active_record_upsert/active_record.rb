module ActiveRecordUpsert
  module ActiveRecord
    def self.included(*)
      require 'active_record_upsert/active_record/persistence'
      ::ActiveRecord::Base.extend ActiveRecordUpsert::ActiveRecord::Persistence

      if ::ActiveRecord::VERSION::MAJOR == 5
        require 'active_record_upsert/active_record5/relation'

        ::ActiveRecord::Relation.include ActiveRecordUpsert::ActiveRecord5::Relation
      elsif ::ActiveRecord::VERSION::MAJOR == 6
        require 'active_record_upsert/active_record6/relation'

        ::ActiveRecord::Relation.include ActiveRecordUpsert::ActiveRecord6::Relation
      end
    end
  end
end
