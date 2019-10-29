ActiveRecord::Schema.define do
  self.verbose = false

  create_table :books, force: true do |t|
    t.string(:title)
    t.string(:author)
    t.integer(:count)
    t.timestamps

    t.index(%i(title author), unique: true)
  end
end
