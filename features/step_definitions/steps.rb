require 'erb'

Given(%r{^a '\.teewt' config with data:$}) do |data_str|
  data = ERB.new(data_str).result(binding)
  File.write("#{Dir.pwd}/tmp/aruba/.teewt", data)
end
