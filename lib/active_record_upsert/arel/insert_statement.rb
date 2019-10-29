module ActiveRecordUpsert
  module Arel
    module InsertStatement
      attr_accessor :on_duplicate

      def initialize
        super()
        @on_duplicate = nil
      end
    end
  end
end
