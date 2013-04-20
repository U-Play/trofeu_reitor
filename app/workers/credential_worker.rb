class CredentialWorker
  @queue = :credentials
  def self.perform(user)
    outfile_path = Rails.root.join('public')
    view_path = Rails.root.join('app', 'views', 'credentials')

    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths
    pdf_html = av.render 
      template: "credentials/print.pdf.erb", 
      layout: 'layouts/credentials.html.erb', 
      margin: {
        top: 20,
        bottom: 20,
        left: 13,
        right: 13
      }

    pdf = WickedPdf.new.pdf_from_string(pdf_html)

    file = Tempfile.new('credentials.pdf', encoding: 'UTF-8')
    file.binmode
    file.write(pdf)
    file.close

    Zip::ZipFile.open(Rails.root.join("public/credentials#{Time.now.strftime("%Y-%m-%d_%H:%M")}.zip"), Zip::ZipFile::CREATE) do |z|
      z.add("1.pdf", file.path)
    end

    file.delete
  end

end


class ActionView::Base
  def protect_against_forgery?
    false
  end
end
