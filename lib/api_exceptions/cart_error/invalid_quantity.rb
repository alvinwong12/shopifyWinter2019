module ApiExceptions
  class CartError < StandardError
    class InvalidQuantity < ApiExceptions::CartError
    end
  end
end