require 'tele_config/version'
require 'tele_config/source'
require 'tele_config/sources/s3'

require 'fileutils'
require 'pathname'

module TeleConfig
  ENV_PREFIX = 'TC'

  require 'tele_config/railtie' if defined?(Rails)

  module_function

  def download(type, dest, prefix: ENV_PREFIX)
    src = source type, prefix: prefix

    download_source src, dest
  end

  def download_source(src, dest)
    create_file_directory dest

    File.open(dest, 'w') do |file|
      file.write src.read
    end
  end

  def source(type, prefix: ENV_PREFIX)
    src_class = lookup_source type
    src_class.new params_from_env(src_class.parameters, prefix)
  end

  def params_from_env(params, prefix)
    entries = params.map do |key, default|
      [key, ::ENV.fetch("#{prefix}_#{key.to_s.upcase}", default)]
    end

    Hash[entries]
  end

  def lookup_source(type)
    src = TeleConfig::Source.descendants.find do |s|
      s.name =~ /::#{type}$/i
    end

    src || raise("Unkown source: #{type}")
  end

  def create_file_directory(file)
    FileUtils.mkdirs_p Pathname(file).dirname
  end
end
