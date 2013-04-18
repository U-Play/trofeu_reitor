ActiveAdmin.register User do
  menu :priority => 11

  filter :role, member_label: Proc.new { |r| r.name.titleize }
  filter :first_name_or_last_name, as: :string
  filter :email
  filter :student_number
  filter :sports_number

  action_item :only => :show, if: proc{ user.can_validate? } do
    link_to 'Validate', validate_admin_user_path(user)
    #link_to admin_validate_user_path
    #tournament = Tournament.find(params[:id])
    #FIXME os seguintes links dao erro
    #link_to('Group Stage Configuration', admin_tournament_group_stages_path(tournament.id)) if tournament.has_group_stage?

  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:role)
    end

    def validate
    end
  end

  index do
    column :name, sortable: 'first_name'
    column :email
    column(:role, sortable: 'roles.name') { |user| user.role.name.titleize }
    column :student_number
    column :sports_number
    default_actions
  end

  show do
    attributes_table do
      row(:picture) { |user| image_tag(user.picture.url) }
      row :first_name
      row :last_name
      row :email
      row :course
      row :student_number
      row :sports_number
    end
  end

  form do |f|
    f.inputs "Required Fields" do
      f.input :email
      f.input :role, include_blank: false, member_label: Proc.new{ |r| r.name.titleize }
    end
    f.inputs "Details" do
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url)
      f.input :first_name
      f.input :last_name
      f.input :student_number
      f.input :sports_number
    end
    f.actions
  end
end
