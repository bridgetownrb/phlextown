class PhlexMe < Phlex::HTML
  def initialize(tagline:)
    @tagline = tagline
    @site = Bridgetown::Current.site
  end

  def template(&blk)
    article class: "tagline" do
      p { @tagline }
      aside { helpers.markdownify("**Strong**") }
      render StandardComponent.new do
        output { site.metadata.title }
      end
      footer(&blk)
    end

    liquid_render "liquidity"
  end
end
