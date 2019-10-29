module ActiveRecordUpsert
  module Arel
    module Visitors
      module MySQL
        def visit_Arel_Nodes_InsertStatement(obj, collector) # rubocop:disable Naming/MethodName
          collector = super(obj, collector)
          return collector unless obj.on_duplicate

          collector << ' ON DUPLICATE KEY UPDATE'
          maybe_visit(obj.on_duplicate.expr, collector)
        end
      end
    end
  end
end
