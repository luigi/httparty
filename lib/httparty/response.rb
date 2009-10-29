module HTTParty
  class Response < BasicObject #:nodoc:
    RESPONDS_TO = /^((body|code|message|headers)=?|delegate)$/
    attr_accessor :body, :code, :message, :headers
    attr_reader :delegate

    def initialize(delegate, body, code, message, headers={})
      @delegate = delegate
      @body = body
      @code = code.to_i
      @message = message
      @headers = headers
    end

    def method_missing(name, *args, &block)
      @delegate.send(name, *args, &block)
    end

    def respond_to?(method)
      return true if method.to_s.match(RESPONDS_TO)
    end
  end
end
