#!/usr/bin/env ruby

=begin
Author:       Roberto Gibellini
License:      GPL 3.0
Version 0.1 - 15/09/2016
=end

#============
t1 = Time.now
BEGIN { puts "Date and time: " + Time.now.to_s }

# Initialize Libraries
######################

$LOAD_PATH.unshift('./lib')

require 'yaml'
require 'myYAML'

# Checking Required Argument
############################

# Get parameters
arg1 = ARGV.shift
arg2 = ARGV.shift
arg3 = ARGV.shift
arg4 = ARGV.shift

raise "Missing argument" + "
===========================================================
Usage: ./delete.rb <service> <element> <host> <instance>
e.g.: ./delete.rb app1 tomcat host01 app1-instance01
===========================================================
" unless arg4

# Config & Variables
####################

home = Dir.pwd
service = arg1
element = arg2
host = arg3
instance = arg4

output_dir = home + "/output/" + service + "/" + element
template = home + "/templates/" + service + "/" + element + ".yaml"

# Add new "instance" to specific "host" yaml file
#################################################

file = output_dir + '/' + element + '_' + host + '.yaml'

obj = MyYAML.read(file)
obj.delete(instance)
File.open(file, "w") {|f| f.write(YAML.dump(obj))}

#============
t2 = Time.now
delta = t2 - t1
END { puts "Time elapsed: " + delta.to_s }
