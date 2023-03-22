# frozen_string_literal: true

# Bridgetown-specific workaround that got copied over from the phlex-rails gem (for now)
module Phlextown
  module Renderable
    def render(*args, **kwargs, &block)
      renderable = args[0]

      case renderable
      when Phlex::SGML, Proc
        return super
      when Class
        return super if renderable < Phlex::SGML
      when Enumerable
        unless defined?(ActiveRecord::Relation) && renderable.is_a?(ActiveRecord::Relation)
          return super
        end
      else
        # NOTE: the capture here must diverge from the phlex-rails code, otherwise rendering a
        # Bridgetown component with content block from a Phlex component has a source ordering
        # problem. I wonder why?
        @_context.target << @_view_context.render(*args, **kwargs) { capture(&block) }
      end

      nil
    end

    def render_in(view_context, &block) # rubocop:disable Metrics/MethodLength
      if block
        call(view_context: view_context) do |*args|
          original_length = @_context.target.length

          output = if args.length == 1 && Phlex::SGML === args[0]
                     view_context.capture(
                       args[0].unbuffered, &block
                     )
                   else
                     view_context.capture(*args, &block)
                   end

          unchanged = (original_length == @_context.target.length)

          if unchanged
            case output
            when ActiveSupport::SafeBuffer
              @_context.target << output
            end
          end
        end.html_safe
      else
        call(view_context: view_context).html_safe
      end
    end

    def capture
      super&.html_safe
    end

    def plain(content)
      case content
      when ActiveSupport::SafeBuffer
        @_context.target << content
      else
        super
      end
    end

    # Trick ViewComponent into thinking we're a ViewComponent to fix rendering output
    def set_original_view_context(view_context); end # rubocop:disable Naming/AccessorMethodName
  end
end
