module ApiExceptions
  class CartError < StandardError
    class CartModificationFail < ApiExceptions::CartError
    end
  end
end