# Next: instead of 'require yaml' USE 'require psych'
# Psych is a YAML parser and emitter
# http://ruby-doc.org/stdlib-2.3.0/libdoc/psych/rdoc/Psych.html

module MyYAML

# Read yaml files
def MyYAML.read(yaml_file)
  YAML.load(File.open(yaml_file))
  rescue Exception => e
  puts "Could not parse YAML: #{e.message}"
end

# Get the leaf nodes in a YAML tree
def MyYAML.traverse(obj, &blk)
  case obj
  when Hash
    # Forget keys because I don't know what to do with them
    obj.each {|k,v| traverse(v, &blk)}
  when Array
    obj.each {|v| traverse(v, &blk)}
  else
    blk.call(obj)
  end
end

# HOW TO USE IT
#MyYAML.traverse(obj) do |node|
#  puts node
#end

# Print nicely YAML content
def MyYAML.nice(obj)
  obj.each_pair { |key, value|
    p "#{key}"
    if value.is_a? Array
      value.each do |item|
        p "  item"
      end
    end
    if value.is_a? Hash
      value.each_pair { |pippo, pluto|
        puts "  #{pippo} = #{pluto}"
      }
    end
  }
end

# HOW TO USE IT
#MyYAML.nice(obj)

def MyYAML.tomcat(obj, instance, offset)
  new_obj = obj.dup
  new_obj[instance] = new_obj.delete('INSTANCE')
  new_obj[instance].each_pair { |key, value|
    value.sub!(/-OFFSET/, offset)
  }
  return new_obj
end

end
