ActiveAdmin.register User do
  menu :priority => 11

  filter :role, member_label: Proc.new { |r| r.name.titleize }
  filter :first_name
  filter :last_name
  filter :email
  filter :student_number
  filter :sports_number

  controller do
    def scoped_collection
      end_of_association_chain.includes(:role)
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

  form do |f| #html: { enctype: 'multipart/form-data' } do |f|
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
