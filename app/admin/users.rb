ActiveAdmin.register User do
  menu :priority => 11

  controller do
    def scoped_collection
      end_of_association_chain.includes(:role)
    end
  end

  action_item :only => :show, if: proc{ user.can_validate? } do
    link_to 'Validate', validate_admin_user_path(user), method: :post
  end

  action_item :only => :show, if: proc{ user.validation_requested? } do
    link_to 'Invalidate', invalidate_admin_user_path(user), method: :post
  end

  filter :role, member_label: Proc.new { |r| r.name.titleize }
  filter :first_name_or_last_name, as: :string
  filter :email
  filter :student_number
  filter :sports_number

  scope :all, default: true
  scope(:pending_validation) { User.with_validation_requested }
  scope(:validated) { User.with_validation_finished }

  index do
    column :validation_state
    column :name, sortable: 'first_name'
    column :email
    column(:role, sortable: 'roles.name') { |user| user.role.name.titleize }
    column :student_number
    column :sports_number
    default_actions
  end

  show do
    attributes_table do
      row :validation_state
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

  member_action :validate, method: :post do
    user = User.find(params[:id])
    user.validate!
    redirect_to action: :show, notice: "User #{user.name} validated"
  end

  member_action :invalidate, method: :post do
    user = User.find(params[:id])
    user.invalidate!
    redirect_to action: :show, notice: "User #{user.name} validation rejected"
  end
end
