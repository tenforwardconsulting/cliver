# encoding: utf-8

require 'open3'

module Cliver
  module Which
    # Windows-specific implementation of Which
    # Required and mixed into Cliver::Which in windows environments
    module Windows
      # @param executable [String]
      # @return [nil,String] - path to found executable
      def which(executable)
        # `where` returns newline-separated files found on path, but doesn't
        # ensure that they are executable as commands.
        where, _, _ = Open3.capture3('where', executable)
        where.split("\n").find do |found|
          next if found.empty?
          File.executable?(found)
        end
      rescue Errno::ENOENT
        raise '"where" must be on your path to use Cliver on Windows.'
      end
    end
  end
end
