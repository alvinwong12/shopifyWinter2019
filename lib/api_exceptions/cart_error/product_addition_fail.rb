module ApiExceptions
  class CartError < StandardError
    class ProductAdditionFail < ApiExceptions::CartError
    end
  end
end