#   Copyright (C) 2013-2014 Computer Sciences Corporation
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# recursively load files given base directory and pattern
# using puts because logger is not active at this point
module Loader
  def self.load dir, pattern
    Dir.entries(dir).sort.each do |filename|
      if File.directory?(File.join(dir,filename)) and not ['.','..'].include? filename
        self.load(File.join(dir, filename), pattern)
      elsif filename =~ pattern
        require File.join dir, filename
      end
    end
  end
end


### XXX - Bobby is there a better way?
include Java

java_classpath = File.join(Rails.root, 'config', 'java_config') + '/'
$CLASSPATH << java_classpath

# load jars
Loader.load File.join(Rails.root, 'lib', 'jars'), /.*\.jar/

# load Amino classes
require File.join Rails.root, 'lib', 'classes', 'amino.rb'