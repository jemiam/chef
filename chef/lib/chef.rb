#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'extlib'
require 'chef/exceptions'
require 'chef/log'
require 'chef/config'
Dir[File.join(File.dirname(__FILE__), 'chef/mixin/**/*.rb')].sort.each { |lib| require lib }

class Chef
  VERSION = '0.8.0'
end

# Adds a Dir.glob to Ruby 1.8.5, for compat
if RUBY_VERSION < "1.8.6" 
  class Dir 
    class << self 
      alias_method :glob_, :glob 
      def glob(*args) 
         raise ArgumentError if args.empty? 
         args.inject([]) { |r, p| r + glob_(p) } 
      end 
      alias_method :[], :glob 
    end 
  end 
end 
