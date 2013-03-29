ActiveAdmin.register Format, :as => "TournamentFormat" do
  index do
    column(:name) { |format| link_to format.name, admin_tournament_format_path(format) }

    default_actions
  end

  form do |f|
    f.inputs "Format Details" do
      f.input :name, :required => true
      f.input :description
    end
    f.buttons
  end

  show :title => :name do
    attributes_table do
      [:name, :description].each do |column|
        row column
      end
    end
    panel "Tournaments" do
      table_for tournament_format.tournaments 
      # do
      #   column("name") { |format| link_to format.name, admin_format_path(format) }
      #   column("Description") { |format| format.description }
      # end
    end
  end

  # Filter only by
  filter :name
  filter :description
end
