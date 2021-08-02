require_relative './constants'
require 'faraday'
require 'faraday_middleware'
require 'faraday/encoding'

module AssertivaRb
  class Request

    def fetch(product:, http_method:, params:)
      retries = 3
      url = get_url(product, params)

      response = client.public_send(http_method, url, params[:data])

      error = error_class(response.status)
      raise error.new(
        response.status,
        response.body,
        params.to_json
      ) if error

      return response.body
    end

    private

    def client
      @_client ||= Faraday.new(url: AssertivaRb::URL) do |faraday|
        faraday.adapter Faraday.default_adapter

        faraday.headers["Authorization"] = AssertivaRb::API_TOKEN

        faraday.request :json

        faraday.response :encoding
        faraday.response :json, content_type: /\bjson$/
      end
    end

    def error_class(status)
      case status
      when HTTP_OK_CODE then nil
      when HTTP_FORBIDDEN_CODE then AssertivaRb::ForbiddenError
      when HTTP_NOT_FOUND_CODE then AssertivaRb::DataNotFoundError
      when HTTP_BAD_REQUEST_CODE then AssertivaRb::BadRequestError
      when HTTP_UNAUTHORIZED_CODE then AssertivaRb::UnauthorizedError
      when HTTP_REQUEST_TIMEOUT_CODE then AssertivaRb::RequestTimeoutError
      when HTTP_UNPROCESSABLE_ENTITY_CODE then AssertivaRb::UnprocessableEntityError
      else ApiGatewayError
      end
    end

    def get_url(product, params)
      lote_url = Proc.new {}
      localize_url = Proc.new do |key|
        base_path = Proc.new do |code|
          File.join(['v2', 'localize', code, 'consultar'])
        end

        nillify = true
        params[:data].merge!({
          idFinalidade: AssertivaRb::QUERY_TYPE
        })

        code = case params[:data_type]
        when 'cpf' then '1000'
        when 'cnpj' then '1001'
        when 'name', 'address'
          nillify = false
          '1004'
        when 'related' then '1005'
        when 'registration_data_pf' then '1007'
        when 'registration_data_pj' then '1008'
        end


        query = params[:data].dup
        params[:data] = nil if nillify

        [ base_path.call(code),
          URI.encode_www_form(query)
        ].join('?')
      end

      case product
      when 'localize'then localize_url.call(params[:data].keys[0])
      when 'lote' then lote_url.call
      end
    end
  end
end
