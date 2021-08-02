# frozen_string_literal: true
require "assertiva_rb/version"

require "assertiva_rb/errors"
require "assertiva_rb/localize"
require 'assertiva_rb/request'

require 'pry'

module AssertivaRb
  URL = ENV.fetch("ASSERTIVA_RB_URL", 'https://services.assertivasolucoes.com.br')
  QUERY_TYPE = ENV.fetch("ASSERTIVA_RB_QUERY_TYPE", 5).to_i

  begin
    API_TOKEN = ENV.fetch("ASSERTIVA_RB_TOKEN")
  rescue
    raise AssertivaRb::NoApiKeyError
  end

  Client ||= AssertivaRb::Request.new
end
