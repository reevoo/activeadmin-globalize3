ActiveAdmin.register Post do
 index do
   column :id 
   column :title
   column :text
   translation_status
   default_actions
 end  
 form do |f|
    f.translated_inputs do |t|
      t.input :title
      t.input :text
    end
    f.actions
  end
end
