module ActiveRecordUpsert
  module ActiveRecord
    module Persistence
      def _upsert_record(values, on_duplicate)
        set_timestamps(values)
        set_primary_key_value(values) unless composite?

        im = compile_insert(values, on_duplicate)
        connection.insert(im, "#{self} Upsert", primary_key || false, values[primary_key])
      end

      private

      def set_timestamps(values) # rubocop:disable Naming/AccessorMethodName
        return unless record_timestamps

        current_time = current_time_from_proper_timezone

        all_timestamp_attributes_in_model.each do |column|
          values[column] = current_time unless values.include?(column)
        end
      end

      def set_primary_key_value(values) # rubocop:disable Naming/AccessorMethodName
        primary_key = self.primary_key
        return unless primary_key && values.is_a?(Hash)

        primary_key_value = values[primary_key]
        primary_key_value ||= next_sequence_value if prefetch_primary_key?
        values[primary_key] = primary_key_value
      end

      def compile_insert(values, on_duplicate)
        if values.empty?
          im = arel_table.compile_insert(connection.empty_insert_statement_value(primary_key))
          im.into(arel_table)
        else
          im = arel_table.compile_insert(_substitute_values(values))
        end

        im.on_duplicate_update(on_duplicate)
        im
      end

      def composite?
        return false unless defined?(super)
        super
      end
    end
  end
end
