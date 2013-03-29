ActiveAdmin.register Team do
  form do |f|
    f.inputs "Required Fields" do
      f.input :tournament_id, :as => :select, :collection => Tournament.all, :label_method => :name,
              :value_method => :id, :required => true
      f.input :coach_id, :as => :select, :collection => User.all, :label_method => :name,
              :value_method => :id
      f.input :name
    end
    f.actions
  end
  
end
