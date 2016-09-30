#!/usr/bin/env ruby

=begin
Author:       Roberto Gibellini
License:      GPL 3.0
Version 0.1 - 14/09/2016
=end

#============
t1 = Time.now
BEGIN { puts "Date and time: " + Time.now.to_s }

# Initialize Libraries
######################

$LOAD_PATH.unshift('./lib')

require 'yaml'
require 'myYAML'
require 'myTomcat'

# Checking Required Argument
############################

# Get parameters
arg1 = ARGV.shift
arg2 = ARGV.shift
arg3 = ARGV.shift
arg4 = ARGV.shift
arg5 = ARGV.shift

raise "Missing argument" + "
===============================================================
Usage: ./modify.rb <service> <element> <host> <instance> <offset>
e.g.: ./modify.rb app1 tomcat host01 app1-instance01 069
===============================================================
" unless arg5

# Config & Variables
####################

home = Dir.pwd
service = arg1
element = arg2
host = arg3
instance = arg4
offset = arg5

output_dir = home + "/output/" + service + "/" + element
template = home + "/templates/" + service + "/" + element + ".yaml"

# Add new "instance" to specific "host" yaml file
#################################################

file = output_dir + '/' + element + '_' + host + '.yaml'

case element
  when 'tomcat' then function = MyTomcat
  when 'apache' then function = 'MyApache'
  when 'context' then function = 'MyContext'
  when 'shib' then function = 'MyShib'
  when 'modjk' then function = 'MyModjk'
end

# Genero il mio yaml
out_obj = function.modify(template, file, instance, offset)

File.open(file, "w") {|f| f.write(YAML.dump(out_obj))}

#============
t2 = Time.now
delta = t2 - t1
END { puts "Time elapsed: " + delta.to_s }
