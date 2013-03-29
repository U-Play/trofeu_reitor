ActiveAdmin.register Event do
  index do
    column(:name)     { |event| link_to event.name, admin_event_path(event) }
    column(:user_id) { |event| link_to event.user.name, admin_user_path(event.user) }
    column(:start_date)

    default_actions
  end

  form do |f|
    f.inputs "Event Details" do
      f.input :user, :required => true
      f.input :name, :required => true
      f.input :description
      f.input :start_date, :required => true, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.buttons
  end

  show :title => :name do
    attributes_table do
      row(:name)
      row(:description)
      row(:user) { link_to event.user.name, admin_user_path(event.user) }
    end
    panel "Tournaments" do
      table_for event.tournaments
      # do |t|
      #   t.column("name") { |event| link_to event.name, admin_event_path(event) }
      #   t.column("Description") { |event| event.description }
      # end
    end
  end

  sidebar "Other Events For This User", :only => :show do
    table_for User.find(event.user_id).events do
      column(:name) { |event| link_to event.name, admin_event_path(event) }
      column(:start_date) { |event| event.start_date }
    end
  end

  # Filter only by
  filter :user_id
  filter :name
  filter :description

  # Scopes
  scope :all, :default => true
  scope(:on_going)  { |events| events.on_going }
  scope(:coming)    { |events| events.coming }
  scope(:past)      { |events| events.past }

end
