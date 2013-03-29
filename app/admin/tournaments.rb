ActiveAdmin.register Tournament do
  filter :name

  index do
    column :name
    column :start_date
    column :end_date
    default_actions
  end

  show do
    attributes_table do
      row :sport
      row :name
      row :start_date
      row :end_date
    end
  end


  form do |f|
    f.inputs "Required Fields" do
      f.input :sport
      f.input :name
      f.input :description
      f.input :rules
      f.input :contacts
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.actions
  end

end
