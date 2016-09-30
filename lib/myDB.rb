module MyDB

  def MyDB.select(connection,query)
    conn = OCI8.new(connection.at(0),connection.at(1),connection.at(2))
    out = Array.new
    conn.exec(query) do |r|
      # r is an array
      out << r
    end
    return out
    conn.logoff
  end

end
