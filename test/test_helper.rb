require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/pride'
require 'ostruct'

require File.expand_path('../../lib/formation', __FILE__)
require File.expand_path('../forms/simple_form', __FILE__)
require File.expand_path('../forms/post_form', __FILE__)