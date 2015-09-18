# func = proc do |name, filename, line, object_id, binding, class_name|
#   # var_values = vars.each_with_object({}) { |var, hash| hash[var] = binding.local_variable_get(var) }
# 
#   p [line, binding.eval("self"), binding.eval("self.instance_variables")]
#   # var_values = vars.each_with_object({}) { |var, hash| hash[var] = binding.instance_variable_get(var) }
#   # p [filename, line, var_values]
# end
# 
# set_trace_func(func)

DATA__ = []
$trace = TracePoint.new(:line, :return, :b_call, :b_return) do |tp|
  locals = tp.binding.local_variables.each_with_object({})    { |var, hash| hash[var] = tp.binding.local_variable_get(var).inspect }
  binding_self = tp.binding.eval("self")
  ivars  = binding_self.instance_variables.each_with_object({}) { |var, hash| hash[var] = binding_self.instance_variable_get(var).inspect }
  file   = tp.path
  line   = tp.lineno

  DATA__ << {self: tp.self, locals: locals, file: file, line: line, ivars: ivars}
end

at_exit do
  $trace.disable
  require 'json'
  json = {
           data:  DATA__,
           files: DATA__.map { |data| data[:file] }.uniq.each_with_object({}) { |file, contents| contents[file] = File.read(file) }
         }

  puts json.to_json
end


