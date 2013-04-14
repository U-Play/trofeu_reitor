ActiveAdmin.register Highlight do
  menu false

  # Is nested resource of
  belongs_to :sport

  index do
    column(:name)
    column(:description)
    column(:sport_id) { |highlight| link_to highlight.sport.name, admin_sport_path(highlight.sport) }

    default_actions
  end

  form do |f|
    f.inputs "Highlight Details" do
      f.input :sport, required: true
      f.input :name, :required => true
      f.input :description
    end
    f.buttons
  end

  show :title => :name do
    attributes_table do
      row(:name)
      row(:description)
      row(:sport) { link_to highlight.sport.name, admin_sport_path(highlight.sport) }
    end
  end

  # Filter only by
  filter :sport_id
  filter :name
  filter :description

end
