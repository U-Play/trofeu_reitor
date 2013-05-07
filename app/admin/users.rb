ActiveAdmin.register User do
  menu :priority => 11

  controller do
    def scoped_collection
      end_of_association_chain.includes(:role)
    end
  end

  action_item :only => :show, if: proc{ can? :validate, user } do
    link_to 'Validate', validate_admin_user_path(user), method: :post
  end

  action_item :only => :show, if: proc{ can? :invalidate, user } do
    link_to 'Invalidate', invalidate_admin_user_path(user), method: :post
  end

  filter :role, member_label: Proc.new { |r| r.name.titleize }
  filter :first_name_or_last_name, as: :string
  filter :email
  filter :student_number
  filter :sports_number

  scope :all, default: true
  scope(:pending_validation)   { User.without_validation_finished }
  scope(:requested_validation) { User.with_validation_requested }
  scope(:validated)            { User.with_validation_finished }

  index do
    column("Validation") { |u| status_tag u.validation_status[:str], u.validation_status[:type] }
    column :name, sortable: 'first_name'
    column :email
    column(:role, sortable: 'roles.name') { |user| user.role.name.titleize }
    column :student_number
    column :sports_number
    default_actions
  end

  show do
    attributes_table do
      row("Validation") { |u| status_tag u.validation_status[:str], u.validation_status[:type] }
      row(:picture) { |user| image_tag(user.picture.url(:thumb)) }
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
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:default))
      f.input :first_name
      f.input :last_name
      f.input :student_number
      f.input :sports_number
    end
    f.actions
  end

  action_item only: :show do
    link_to 'Credential', credential_admin_user_path(user.id, format: 'pdf')
  end

  member_action :credential, method: :get do
    @athlete = User.find params[:id]
    @host = 'http://'+request.host_with_port
    respond_to do |f|
      f.html
      f.pdf do
        render :pdf => 'credential',
          layout: 'credentials.html',
          :margin => {
          top: 20,
          bottom: 20,
          left: 13,
          right: 13
        }
      end
    end
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
