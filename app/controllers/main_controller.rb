class MainController < ApplicationController
  def index
    @words = Word.order(uses: :desc).limit(30)
  end
end
