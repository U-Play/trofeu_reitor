class CredentialsController < ApplicationController

  def print
    respond_to do |f|
      f.html
      f.pdf do
        render :pdf => 'print',
          layout: 'credentials.html'
      end
    end
  end

end
