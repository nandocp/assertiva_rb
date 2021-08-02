module AssertivaRb
  class Error < StandardError; end

  class NoApiKeyError < Error; end
  class NoCreditError < Error; end
  class NotFoundError < Error; end
  class BlankDataError < Error; end
  class DataClassError < Error; end
  class InvalidDataError < Error; end

  class ApiError < Error
    def initialize(status, body, payload)
      msg = {
        payload: payload,
        status_code: status,
        body: body
      }.to_json

      super(msg)
    end
  end

  class ApiRequestsQuotaReachedError < ApiError; end
  class UnprocessableEntityError < ApiError; end
  class RequestTimeoutError < ApiError; end
  class UnauthorizedError < ApiError; end
  class BadRequestError < ApiError; end
  class ForbiddenError < ApiError; end
  class DataNotFoundError < ApiError; end
  class ApiGatewayError < ApiError; end
end
