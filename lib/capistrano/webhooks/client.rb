require 'faraday'

module Capistrano
  module Webhooks
    class Client
      attr_reader :url, :options

      def initialize(url, options)
        @url     = url
        @options = options
      end

      def run
        return if dry_run?

        connection.send options[:method], url.to_s, options[:payload]
      end

      private

      def dry_run?
        ::Capistrano::Configuration.env.dry_run?
      end

      def connection
        Faraday.new do |faraday|
          faraday.request :multipart
          faraday.request :url_encoded
          faraday.options.timeout       = 15
          faraday.options.open_timeout  = 15
          faraday.adapter Faraday.default_adapter
        end
      end
    end
  end
end
