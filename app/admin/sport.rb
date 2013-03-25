ActiveAdmin.register Sport do

  filter :name

  index do
    column :name
    default_actions
  end

  show do
    attributes_table do
      row :name
    end
  end

  form do |f|
    f.inputs "Required Fields" do
      f.input :name
    end
    f.actions
  end

end
