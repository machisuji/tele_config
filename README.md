[![Code Climate](https://codeclimate.com/github/machisuji/tele_config/badges/gpa.svg)](https://codeclimate.com/github/machisuji/tele_config)

# TeleConfig

A gem used to download configuration files from different sources.
One specific use case is downloading configuration files to docker containers at startup.

With that in mind configuration sources are defined through environment variables.

## Installation

Add this line to your application's Gemfile:

    gem 'tele_config', git: 'https://github.com/machisuji/tele_config.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tele_config

## Usage

The single main method through which you can use TeleConfig is `TeleConfig.download`.
It expects the type of source and a destination. Optionally you can provide another
environment variable name prefix to be used for looking up the required parameters
in the environment.

### S3 Example

```bash
export TC_ACCESS_KEY_ID=AKUHSGYFGSYGFSG
export TC_SECRET_ACCESS_KEY=8h4t9hgrwh8h4gh3gh

export TC_REGION=eu-west-1
export TC_BUCKET=configuration_bucket
export TC_PATH=staging/configuration.yml

bundle console
```

Once in the console run the following to download the file:

```ruby
TeleConfig.download :s3, 'config/configuration.yml'
```

### URI Example

```bash
export TC_URI=https://www.google.co.uk/robots.txt

bundle console
```

Then on the console:

```ruby
TeleConfig.download :uri, './robots.txt'
```

### Custom ENV Prefix

```bash
export MY_CONFIG_URI=https://www.google.co.uk/robots.txt

bundle console
```

Then on the console:

```ruby
TeleConfig.download :uri, './robots.txt', prefix: 'MY_CONFIG'
```

### Rake Task Use (Rails)

TeleConfig provides a rake task for Rails 3+ which you can use.

```bash
TC_URI=https://www.google.co.ukk/robots.txt rake tele_config[uri,./robots.txt]
```

Custom prefixes are supported too:

```bash
MY_CONFIG_URI=https://www.google.co.ukk/robots.txt rake tele_config[uri,./robots.txt,MY_CONFIG]
```

### Explicit Use

Of course no one is stopping you from using the sources directly.

```ruby
src = TeleConfig::Sources::URI.new 'https://www.google.co.uk/robots.txt'

TeleConfig.download_source src, './robots.txt'
```

## Sources

Currently TeleConfig comes with the URI and S3 sources only.

## Contributing

1. Fork it ( https://github.com/machisuji/tele_config/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
