module MyConfig

 def MyConfig.getconfig(home, service)
   service_config = YAML.load_file(home + "/config/" + service + "/config.yaml")
   db = service_config['db_instance']
   server = service_config['db_instance']['server1']
   user = service_config['db_instance']['user']
   password = service_config['db_instance']['password']

   return values = [user, password, server]
 end

 def MyConfig.getquery(home, service)
   query_config = YAML.load_file(home + "/config/" + service + "/queries.yaml")
   servers = query_config['queries']['tomcat_hosts']
   instances = query_config['queries']['tomcat_instances']

   return values = [servers, instances]
 end

end
