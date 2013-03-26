ActiveAdmin.register Highlight do
  index do
    column :name
    column :description
    column :sport_id do |highlight|
      link_to highlight.sport.name, admin_sport_path(highlight.sport)
    end

    default_actions
  end

  form do |f|
    f.inputs "Highlight Details" do
      f.input :sport_id, :as => :select, :collection => Sport.all, :label_method => :name,
              :value_method => :id, :required => true
      f.input :name, :required => true
      f.input :description
    end
    f.buttons
  end

  show :title => :name do
    attributes_table do
      row :name
      row :description
      row("Sport") { link_to highlight.sport.name, admin_sport_path(highlight.sport) }
    end
  end

  # Filter only by
  filter :sport_id
  filter :name
  filter :description

end
