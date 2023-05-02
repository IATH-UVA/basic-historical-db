ActiveAdmin.register Era do
  menu parent: 'Controlled Vocabularies'
  
  permit_params :name, :description

  preserve_default_filters!
  remove_filter :events

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
      row :events do |x|
        ul do
          x.events.each do |event|
            li link_to event.title.present? ? event.title : event.id, admin_event_path(event)
          end
        end
      end
    end
  end
  
end
