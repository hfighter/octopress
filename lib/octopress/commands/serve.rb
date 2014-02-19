require 'jekyll'
require File.expand_path('helpers', File.dirname(__FILE__))

module Octopress
  class Serve < Command
    def self.init_with_program(p)
      p.command(:serve) do |c|
        c.alias(:server)

        c.syntax 'jekyll serve [options]'
        c.description 'Serve your site locally'

        Helpers.add_build_options(c)

        c.option 'detach', '-B', '--detach',      'Run the server in the background (detach)'
        c.option 'port',   '-P', '--port PORT',   'Port to listen on'
        c.option 'host',   '-H', '--host HOST',   'Host to bind to'
        c.option 'baseurl',      '--baseurl URL', 'Base URL'

        c.action do |args, options|
          options.default :serving => true
          options = Helpers.normalize_options(options)
          options = ::Jekyll.configuration(options.to_symbol_keys)
          ::Jekyll::Commands::Build.process(options)
          ::Jekyll::Commands::Serve.process(options)
        end
      end
    end
  end
end

