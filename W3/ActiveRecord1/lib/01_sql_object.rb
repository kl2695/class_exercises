require_relative 'db_connection'
require 'active_support/inflector'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    cols = DBConnection.execute2(<<-SQL)
      SELECT *
      FROM #{self.table_name}

    SQL

    @columns = cols.first.map(&:to_sym)
  end

  def self.finalize!

    cols = self.columns

    cols.each do |col|
      define_method("#{col}") do
        attributes[col]
      end
      define_method("#{col}=") do |value|
        attributes[col] = value
      end

    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name

  end

  def self.table_name
    # ...
    @table_name = "#{self}s".downcase
  end

  def self.all
    # ...

    cols = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL

    return parse_all(cols)
  end

  def self.parse_all(results)
    # ...
    results.map{|hash| self.new(hash)}
  end

  def self.find(id)
    # ...
    results = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE #{self.table_name}.id = ?
    SQL

    return parse_all(results).first unless results.length == 0
    nil
  end

  def initialize(params = {})
    # ...

    params.each do |k,v|
      k = k.to_sym
      if self.class.columns.include?(k)
        self.send("#{k}=", v)
      else
        raise "unknown attribute '#{k}'"
      end
    end

  end

  def attributes
    # ...
  @attributes ||= {}

  end

  def attribute_values
    # # ...
    self.class.columns.map {|att| self.send(att)}



  end

  def insert
    # ...
    cols = self.class.columns.drop(1)
    col_names = cols.map(&:to_s).join(", ")
    question_marks = (["?"] * cols.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1) )
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id

  end

  def update
    # ...
    set_line = self.class.columns
          .map { |attr| "#{attr} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE #{self.class.table_name}
      SET #{set_line}
      WHERE id = ?

    SQL



  end

  def save
    # ...

    id.nil? ? insert : update
  end
end
