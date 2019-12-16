require 'spec_helper'

RSpec.describe ActiveRecordUpsert::ActiveRecord do # rubocop:disable RSpec/FilePath
  describe '#upsert' do
    context 'when a record already exists' do
      it 'updates the record' do
        Book.create!(title: 'Monkey and Me', author: 'Emily Gravett', count: 5)
        Book.where(title: 'Monkey and Me', author: 'Emily Gravett').upsert(count: 'count + 1')
        book = Book.last
        expect(book.count).to eq(6)
      end

      it 'updates the record without changing things that should not change' do # rubocop:disable RSpec/ExampleLength
        timestamp = 1.week.ago.to_date

        # Don't allow the timestamps to be automatically overwritten
        ActiveRecord::Base.record_timestamps = false
        Book.create(title: 'Monkey and Me', author: 'Emily Gravett', count: 5, created_at: Time.now, updated_at: timestamp)
        ActiveRecord::Base.record_timestamps = true

        Book.where(title: 'Monkey and Me', author: 'Emily Gravett').upsert(count: 'count + 1')
        book = Book.last

        expect(book.count).to eq(6)
        expect(book.updated_at).to eq(timestamp)
      end
    end

    context 'when a record does not already exist' do
      it 'inserts a new record' do
        Book.where(title: 'Monkey and Me', author: 'Emily Gravett', count: 1).upsert(count: 'count + 1')
        book = Book.last
        expect(book.count).to eq(1)
      end
    end

    context 'with composite_primary_keys', composite: true do
      it do
        registration = Registration.create!(user_id: 1, course_id: 2)
        Registration.where(user_id: 1, course_id: 2).upsert("grade = 'A+'")

        expect(Registration.count).to eq(1)

        expect { registration.reload }.to change { registration.grade }.from(nil).to('A+')
      end
    end
  end
end
