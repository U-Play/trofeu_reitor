ActiveAdmin.register Highlight do
  index do
    column :name do |highlight|
      link_to highlight.name, admin_highlight_path(highlight)
    end
    column :description
    column :sport_id do |highlight|
      link_to highlight.sport.name, admin_sport_path(highlight.sport)
    end

    default_actions
  end

  form do |f|
    f.inputs "Highlight Details" do
      f.input :sport_id, :as => :select, :collection => Sport.all, :label_method => :name, :value_method => :id
      f.input :name
      f.input :description
    end
    f.buttons
  end

  show :title => :name do
    panel "Highlight Details" do
      attributes_table_for highlight do
        row("Name") { highlight.name }
        row("Description") { highlight.description }
        row("Sport") { link_to highlight.sport.name, admin_sport_path(highlight.sport) }
      end
    end
    # panel "Tournaments" do
    #   table_for sport.tournaments
    #   # do |t|
    #   #   t.column("name") { |highlight| link_to highlight.name, admin_highlight_path(highlight) }
    #   #   t.column("Description") { |highlight| highlight.description }
    #   # end
    # end

    # panel "Highlights" do
    #   table_for sport.highlights do |t|
    #     t.column("name") { |highlight| link_to highlight.name, admin_highlight_path(highlight) }
    #     t.column("Description") { |highlight| highlight.description }
    #   end
    # end
  end

  # Filter only by
  filter :sport_id
  filter :name
  filter :description

end
