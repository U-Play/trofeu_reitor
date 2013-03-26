ActiveAdmin.register Team do

  filter :name

  controller do
    def scoped_collection
      end_of_association_chain.includes(:tournament)
    end
  end

  index do
    column :name
    column(:tournament, sortable: 'tournament.name') { |team| team.tournament.name }
    column(:coach, sortable: 'user.first_name') { |team| team.coach.name if team.coach }
    default_actions
  end

  show do
    attributes_table do
      row :name
    end
  end

  form do |f|
    f.inputs "Required Fields" do
      f.input :tournament
      f.input :name
      f.input :coach, label: 'Select a coach'
      f.input :coach_email, label: 'Or invite a new user to be the coach'
    end
    f.actions
  end

end
