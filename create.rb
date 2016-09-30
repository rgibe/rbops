#!/usr/bin/env ruby

=begin
Author:       Roberto Gibellini
License:      GPL 3.0
Version 0.1 - 25/07/2016
=end

#============
t1 = Time.now
BEGIN { puts "Date and time: " + Time.now.to_s }

# Initialize Libraries
######################

$LOAD_PATH.unshift('./lib')

require 'yaml'
require 'json'
require 'oci8'
require 'myDB'
require 'myS3'
require 'myYAML'
require 'myTomcat'
require 'myConfig'
require 'myCreate'

# Checking Required Argument
############################

# Get parameters
arg1 = ARGV.shift
arg2 = ARGV.shift

raise "Missing argument" + "
======================================================
Usage: ./create.rb <service> <element>
e.g.: ./create.rb app1 tomcat
======================================================
" unless arg2

# Config & Variables
####################

home = Dir.pwd
service = arg1
element = arg2

output_dir = home + "/output/" + service + "/" + element
template = home + "/templates/" + service + "/" + element + ".yaml"

connection = MyConfig.getconfig(home, service)
queries = MyConfig.getquery(home, service)

# Create yaml files for specific "element" (e.g. tomcat,apache)
#############################################################

MyCreate.new(connection, queries, template, output_dir, element)

#============
t2 = Time.now
delta = t2 - t1
END { puts "Time elapsed: " + delta.to_s }
