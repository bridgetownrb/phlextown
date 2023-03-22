# frozen_string_literal: true

module Phlextown
  module Helpers
    # @return [Bridgetown::Site]
    attr_reader :site # will be nil unless you explicitly set a `@site` ivar

    def helpers
      @helpers ||= Bridgetown::RubyTemplateView::Helpers.new(
        self, @_view_context&.site || Bridgetown::Current.site
      )
    end

    def liquid_render(...)
      @_context.target << @_view_context.liquid_render(...)

      nil
    end

    def partial(...)
      @_context.target << @_view_context.partial(...)

      nil
    end
  end
end
