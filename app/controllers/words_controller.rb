class WordsController < ApplicationController
  def show
    @word = Word.find_by(:name => params[:id])
    if @word == nil
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
