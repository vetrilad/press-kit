require 'rest_client'
require 'nokogiri'
require 'progress_bar'
require 'pry'
require 'json'
require 'i18n'

require_relative "lib/person"

require_relative "fetchers/timpul"
require_relative "fetchers/unimedia"

require_relative "parsers/timpul"
require_relative "parsers/unimedia"
