# frozen_string_literal: true

require "bridgetown"
require "phlex"

# @param config [Bridgetown::Configuration::ConfigurationDSL]
Bridgetown.initializer :phlextown do |config|
  require "phlextown/helpers"
  Phlex::HTML.prepend(Phlextown::Helpers)

  unless Phlex::HTML.instance_methods.include?(:render_in)
    require "phlextown/renderable"
    Phlex::HTML.prepend(Phlextown::Renderable)
  end

  config.builder :InlinePhlex do
    def build
      helper :phlex do |**kwargs, &block|
        phlex_component = Class.new(Phlex::HTML)

        phlex_component.define_method :initialize do
          kwargs.each do |k, v|
            instance_variable_set(:"@#{k}", v)
          end
        end

        phlex_component.define_method :template, &block

        helpers.view.render phlex_component.new
      end
    end
  end
end
