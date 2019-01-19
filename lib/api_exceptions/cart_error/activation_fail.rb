module ApiExceptions
  class CartError < StandardError
    class ActivationFail < ApiExceptions::CartError
    end
  end
end