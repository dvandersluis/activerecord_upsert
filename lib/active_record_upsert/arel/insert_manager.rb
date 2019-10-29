module ActiveRecordUpsert
  module Arel
    module InsertManager
      def on_duplicate_update(expr = nil)
        @ast.on_duplicate = OnDuplicate.new(expr, @ast.columns)
      end

      class OnDuplicate < ::Arel::Nodes::Node
        attr_accessor :columns

        def initialize(expr, columns)
          @expr = expr
          @columns = columns
        end

        def expr # rubocop:disable Metrics/MethodLength
          case @expr
            when nil
              eq(first_col, first_col)

            when String
              sql(@expr)

            when Hash
              @expr.map do |key, val|
                eq(sql(key.to_s), sql(val))
              end

            else
              @expr
          end
        end

        private

        def first_col
          sql(columns.first.name.to_s)
        end

        def sql(stmt)
          ::Arel.sql(stmt)
        end

        def eq(left, right)
          ::Arel::Nodes::Equality.new(left, right)
        end
      end
    end
  end
end
