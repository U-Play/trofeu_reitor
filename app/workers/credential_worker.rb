class CredentialWorker
  @queue = :credentials
  def self.perform(user)
    outfile_path = Rails.root
    view_path = Rails.root.join('app', 'views', 'credentials')

    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths
    pdf_html = av.render :template => "credentials/print.pdf.erb", 
      layout: 'layouts/credentials.html.erb', 
      margin: {
        top: 20,
        bottom: 20,
        left: 13,
        right: 13
      }

    #body = File.read(view_path.join('print.pdf.erb'))
    #body_render = Erb.new(body).render(binding)

    pdf = WickedPdf.new.pdf_from_string(pdf_html)
    File.open(outfile_path.join("something.pdf"), 'wb') { |f| f << pdf }

    Zip::ZipFile.open(Rails.root.join("public/credentials#{Time.now.strftime("%Y-%m-%d_%H:%M")}.zip"), Zip::ZipFile::CREATE) do |z|
      z.add("something.pdf", Rails.root.join("something.pdf"))
    end
  end

end


class ActionView::Base
  def protect_against_forgery?
    false
  end
end
