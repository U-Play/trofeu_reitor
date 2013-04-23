class CredentialWorker
  @queue = :credentials
  def self.perform(team_id, user_id)
    outfile_path = Rails.root.join('public')
    view_path = Rails.root.join('app', 'views', 'credentials')

    # render
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths
    #av.assign( @athletes => Team.find(team_id).athletes )
    pdf_html = av.render template: "credentials/print.pdf.erb", 
      layout: 'layouts/credentials.html.erb', 
      margin: {
        top: 20,
        bottom: 20,
        left: 13,
        right: 13
      }, locals: { :athletes => Team.find(team_id).athletes }
    pdf = WickedPdf.new.pdf_from_string(pdf_html)

    # write
    file = Tempfile.new('credentials.pdf', encoding: 'UTF-8')
    file.binmode
    file.write(pdf)
    file.close

    # archive
    zip_file = Rails.root.join("public/credentials#{Time.now.strftime("%Y-%m-%d_%H:%M")}.zip")
    Zip::ZipFile.open(zip_file, Zip::ZipFile::CREATE) do |z|
      z.add("1.pdf", file.path)
    end

    file.delete

    UserMailer.credentials_ready User.find(user_id), zip_file
  end

end


class ActionView::Base
  def protect_against_forgery?
    false
  end
end
