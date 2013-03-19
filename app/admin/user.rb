ActiveAdmin.register User do
  menu :priority => 11

  filter :first_name
  filter :last_name
  filter :email
  filter :student_number
  filter :sports_number

  index do
    column :first_name
    column :last_name
    column :email
    column :student_number
    column :sports_number
    default_actions
  end

  show do
    attributes_table do
      row :picture
      row :first_name
      row :last_name
      row :email
      row :course
      row :student_number
      row :sports_number
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :student_number
      f.input :sports_number
    end
    f.actions
  end
end
