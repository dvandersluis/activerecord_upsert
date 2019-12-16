ActiveRecord::Schema.define do
  self.verbose = false

  create_table :books, force: true do |t|
    t.string(:title)
    t.string(:author)
    t.integer(:count)
    t.timestamps

    t.index(%i(title author), unique: true)
  end

  create_table :registrations, force: true, id: false do |t|
    t.belongs_to(:user)
    t.belongs_to(:course)
    t.string(:grade)
    t.timestamps

    t.index(%i(user_id course_id), unique: true)
  end
end
