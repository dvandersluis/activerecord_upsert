require 'active_record_upsert/version'

require 'arel'
require 'active_record'

require 'active_record_upsert/arel/insert_manager'
require 'active_record_upsert/arel/insert_statement'
require 'active_record_upsert/arel/visitors/mysql'

require 'active_record_upsert/active_record/persistence'
require 'active_record_upsert/active_record/relation'

module ActiveRecordUpsert
end

Arel::Nodes::InsertStatement.include ActiveRecordUpsert::Arel::InsertStatement
Arel::InsertManager.include ActiveRecordUpsert::Arel::InsertManager
Arel::Visitors::MySQL.prepend ActiveRecordUpsert::Arel::Visitors::MySQL

ActiveRecord::Relation.include ActiveRecordUpsert::ActiveRecord::Relation
ActiveRecord::Persistence::ClassMethods.include ActiveRecordUpsert::ActiveRecord::Persistence
