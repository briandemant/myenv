require 'rubygems'
require 'irb/completion'
require 'bond'
require 'pp'
require 'fileutils'
require 'wirble'
require 'interactive_editor'

Wirble.init
Wirble.colorize
IRB.conf[:AUTO_INDENT]=true
IRB.conf[:SIMPLE_PROMPT]=true
