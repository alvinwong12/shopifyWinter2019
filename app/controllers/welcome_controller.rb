class WelcomeController < ApplicationController
  def index
    render plain: "Welcome to Alvin's Marketplace"
  end
end