class CredentialsController < ApplicationController

  def print
    @users = User.all
    Resque.enqueue(CredentialWorker, @users)
    respond_to do |f|
      f.html
      f.pdf do
        render :pdf => 'print',
          layout: 'credentials.html',
          :margin => {
            top: 20,
            bottom: 20,
            left: 13,
            right: 13
          }
      end
    end
  end

end
