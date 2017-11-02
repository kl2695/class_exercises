require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...

    where_line = params.map{|name, value| "#{name} = ?"}.join(" AND ")
    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}

    SQL

    return parse_all(results)
  end

end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
