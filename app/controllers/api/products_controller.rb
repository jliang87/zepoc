module Api
  class ProductsController < ApplicationController
    respond_to :json

    def index
      respond_with User.all
    end

  end
end
