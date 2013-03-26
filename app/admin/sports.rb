ActiveAdmin.register Sport do
  index do
    column :name do |sport|
      link_to sport.name, admin_sport_path(sport)
    end

    default_actions
  end

  form do |f|
    f.inputs "Sport Details" do
      f.input :name, :required => true
    end
    f.buttons
  end

  show :title => :name do
    panel "Tournaments" do
      table_for sport.tournaments
      # do |t|
      #   t.column("name") { |highlight| link_to highlight.name, admin_highlight_path(highlight) }
      #   t.column("Description") { |highlight| highlight.description }
      # end
    end

    panel "Highlights" do
      table_for sport.highlights do |t|
        t.column("name") { |highlight| link_to highlight.name, admin_highlight_path(highlight) }
        t.column("Description") { |highlight| highlight.description }
      end
    end
  end

  # Filter only by name
  filter :name

end
