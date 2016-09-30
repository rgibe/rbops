### RBOPS

The basic idea is to build a "TOOL" in ruby for the "Operations team". As you can see it's just a prototype.

I started the project working on the generation (create.rb) of "yaml files" used to configure servers by puppet in our production env.

The "create" utility get the configuration parameters from an Oracle DB so you should just get the idea.

Out of the box you can "modify" or "delete" existing yaml files with command like:

* ./modify.rb app1 tomcat host01 app1-instance01 069
* ./delete.rb app1 tomcat host01 app1-instance01

Implemented and tested it's just the tomcat part but I tried to give a multitasking approach so you can recycle everything also for different elements (e.g. apache, modjk) and different services (e.g. app2). People in "Operations" just need to add or modify the library (e.g. myApache) with new function.

### DESCRIPTION

In the home directory we have our scripts/utilities:

* create.rb
* modify.rb
* delete.rb

used for the "Operations Tasks" (manually or by jenkins).    

Then, we have the following directories:

* config: configuration files (yaml,json) with queries and DB connections diveded by applications (e.g. app1, app2)

* lib: contains ruby modules with methods used by the utilities
     * myCreate.rb
     * myDB.rb
     * myS3.rb
     * myTomcat.rb
     * myYAML.rb


* output: yaml files used as hiera data files in puppet

* templates: self-explaining

### USAGE

Lets explain how it works.

**Create**

Create and configure the hiera data files (yaml files) depending on the "element" (e.g. tomcat) and "service/application" (e.g. app1)

```Usage: ./create.rb <service> <element>
   E.g.:  ./create.rb app1 tomcat```

The utility reads the configuration parameters from an Oracle DB.

**Modify**

Modify/add a specific configuration instance.
The script get the parameters from command line:

* service/application
* element to work on
* host
* instance
* extra parameter depending on the element (e.g. offset to configure a tomcat instance)

```Usage: ./modify.rb <service> <element> <host> <instance> <offset>
   E.g.:  ./modify.rb app1 tomcat host01 app1-instance01 069```

**Delete**

Delete a specific configuration instance.
The script get the parmeters from command line:

* service/application
* element to work on
* host
* instance

```Usage: ./delete.rb <service> <element> <host> <instance>
   E.g.:  ./delete.rb app1 tomcat host01 app1-instance01```
