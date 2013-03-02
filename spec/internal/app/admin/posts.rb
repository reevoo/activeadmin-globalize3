ActiveAdmin.register Post do
  form do |f|
    f.translated_inputs do |t|
      t.input :title
      t.input :text
    end
    f.actions
  end
end
