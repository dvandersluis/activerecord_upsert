module ActiveRecordUpsert
  module ActiveRecord6
    module Relation
      def upsert(on_duplicate = nil)
        scoping { klass._upsert_record(values_for_create, on_duplicate) }
      end

      private

      def values_for_create
        klass.current_scope.values[:where].to_h
      end
    end
  end
end
