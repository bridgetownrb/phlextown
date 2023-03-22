# Phlextown

A [Bridgetown](https://www.bridgetownrb.com) plugin for rendering [Phlex](https://www.phlex.fun) components.

## Installation

Run this command to add this plugin to your site's Gemfile:

```shell
bundle add phlextown
```

Then add the initializer to your configuration in `config/initializers.rb`:

```ruby
init :phlextown
```

Then you can start writing Phlex components in the `src/_components` folder by subclassing `Phlex::HTML`. You can also use the `phlex` helper in Ruby templates (`.rb`, ERB, Serbea, etc.) for rendering Phlex templates directly inside of page templates.

In your Phlex component you can use the `helper` method to access Bridgetown helpers, such as `markdownify`. You can also render other Bridgetown components from your Phlex templates, including Liquid components via `liquid_render`.

## Testing

* Run `bundle exec rake test` to run the test suite
* Or run `script/cibuild` to validate with Rubocop and Minitest together.

## Contributing

1. Fork it (https://github.com/bridgetownrb/phlextown/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
