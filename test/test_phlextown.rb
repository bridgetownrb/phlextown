# frozen_string_literal: true

require_relative "./helper"

class TestPhlextown < Bridgetown::TestCase
  def setup
    Bridgetown.reset_configuration!
    @config = Bridgetown.configuration(
      "root_dir"    => root_dir,
      "source"      => source_dir,
      "destination" => dest_dir,
      "quiet"       => true
    )
    @config.run_initializers! context: :static
    @site = Bridgetown::Site.new(@config)

    with_metadata title: "My Awesome Site" do
      @site.process
    end
  end

  # rubocop:disable Layout/LineLength
  describe "Phlextown" do
    before do
      @contents = File.read(dest_dir("index.html"))
    end

    it "outputs the Phlex component" do
      assert_includes @contents,
                      "<article class=\"tagline\"><p>weird phlex but ok</p><aside><p><strong>Strong</strong></p></aside><p>STANDARD COMPONENT</p>\n\n<output>My Awesome Site</output><footer>\n  <p>STANDARD COMPONENT</p>\n\n\n</footer></article>here's Liquid"
    end

    it "outputs via a phlex helper" do
      assert_includes @contents,
                      "<section class=\"callout\"><p><em>marked</em></p><article class=\"tagline\"><p>Fantastic!</p><aside><p><strong>Strong</strong></p></aside><p>STANDARD COMPONENT</p>\n\n<output>My Awesome Site</output><footer></footer></article>here's Liquid</section>"
    end
  end
  # rubocop:enable Layout/LineLength
end
