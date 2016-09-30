module MyCreate

  def MyCreate.new(connection, queries, template, output, element)

    servers = queries[0]
    instances = queries[1]
 
    # Select servers
    hosts = MyDB.select(connection, servers)
    hosts.sort!
 
    # Find instances on each server
    hosts.each do |item|
 
      node_instances = instances.sub(/CHANGEME1/,item.first)
      rows = MyDB.select(connection, node_instances)
 
      case element
        when 'tomcat' then function = MyTomcat
        when 'apache' then function = 'MyApache' # To DO
        when 'modjk' then function = 'MyModjk'   # To DO
      end

      # Generate output yaml file
      file = output + '/' + element + '_' + item.first + '.yaml'
      out_obj = function.retriveall(rows, template)
      File.open(file, "w") {|f| f.write(YAML.dump(out_obj))}
    end

  end

end
