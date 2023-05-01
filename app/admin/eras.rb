ActiveAdmin.register Era do
  menu parent: 'Controlled Vocabularies'
  
  permit_params :name, :description
  
end
