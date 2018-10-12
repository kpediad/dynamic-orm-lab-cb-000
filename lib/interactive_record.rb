require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true
    sql = "PRAGMA table_info('#{self.table_name}')"
    table_info = DB[:conn].execute(sql)
    table_info.collect{|col| col['name']}.compact
  end

  def initialize(data = {})
    data.each{|attr, value| self.send("#{attr}=", value)}
  end

  def table_name_for_insert
    self.class.table_name
  end

end
