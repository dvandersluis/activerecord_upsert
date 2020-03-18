module ActiveRecordUpsert
  module ActiveRecord5
    module Relation
      def upsert(on_duplicate = nil)
        scoping { klass._upsert_record(values_for_create, on_duplicate) }
      end
    end
  end
end
