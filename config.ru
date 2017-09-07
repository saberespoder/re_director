require 'dotenv/load'
require_relative 'lib/re_director'

ReDirector.opts[:mode]      = :independent
ReDirector.opts[:contenido] = ENV['CONTENIDO_URL']
ReDirector.opts[:sep]       = ENV['SEP_URL']

run ReDirector.freeze.app
