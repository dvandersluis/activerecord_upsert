require 'spec_helper'

RSpec.describe ActiveRecordUpsert::Arel::InsertManager do
  describe '#on_duplicate_update' do
    let(:im) { Arel::InsertManager.new }

    before do
      im.into(Book.arel_table)
      im.insert(Book.send(:_substitute_values, title: 'Little Blue Truck', author: 'Alice Schertle'))
    end

    context 'when given a string' do
      it 'passes it as the UPDATE value' do
        im.on_duplicate_update('count = VALUES(count) + 1')
        expect(im.to_sql).to end_with('ON DUPLICATE KEY UPDATE count = VALUES(count) + 1')
      end
    end

    context 'when given a hash of strings' do
      it 'builds an UPDATE value' do
        im.on_duplicate_update(count: 'VALUES(count) + 1')
        expect(im.to_sql).to end_with('ON DUPLICATE KEY UPDATE count = VALUES(count) + 1')
      end
    end

    context 'when given no expression' do
      it 'puts a default' do
        im.on_duplicate_update
        expect(im.to_sql).to end_with('ON DUPLICATE KEY UPDATE title = title')
      end
    end

    context 'when updating multiple columns' do
      it 'includes all columns' do
        im.on_duplicate_update(count: 'VALUES(count) + 1', updated_at: 'NOW()')
        expect(im.to_sql).to end_with('ON DUPLICATE KEY UPDATE count = VALUES(count) + 1, updated_at = NOW()')
      end
    end
  end
end
