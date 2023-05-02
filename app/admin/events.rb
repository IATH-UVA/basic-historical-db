ActiveAdmin.register Event do
  menu priority: 3

  permit_params :era_id, :event_type_id, :date_yyyy, :date_mm, :date_dd, :date_display, :title, :text, :link, :source_id, :image

  controller do
    def scoped_collection
      end_of_association_chain.includes([:era, :source, :event_type]).references([:eras, :event_types, :sources])
    end
  end

  preserve_default_filters!
  remove_filter :image_attachment
  remove_filter :image_blob

  index do
    selectable_column
    column :id do |x|
      div x.id
      div link_to 'view', admin_event_path(x)
      div link_to 'edit', edit_admin_event_path(x)
    end
    column :era, sortable: 'eras.name'
    column :event_type, sortable: 'event_types.name'
    column :date_yyyy
    column :date_mm
    column :date_dd
    column :date_display
    column :title
    column :text do |x|
      x.text.try(&:html_safe)
    end
    column :link do |x|
      if x.link.present?
        link_to x.link, x.link
      end
    end
    column :source, sortable: 'sources.title'
    column :image do |x|
      if x.image.attached?
        image_tag x.image
      end
    end
    column :created_at
    column :updated_at
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :era
      f.input :event_type
      f.input :date_yyyy
      f.input :date_mm
      f.input :date_dd
      f.input :date_display
      f.input :title
      f.input :text, as: :quill_editor
      f.input :link
      f.input :source
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        if field == :text
          row "Text" do |x|
            span x.text.try(&:html_safe)
          end
        elsif field == :link
          row "Link" do |x|
            if x.link.present?
              link_to x.link, x.link, target: "_blank"
            end
          end
        else
          row field
        end
      end
      row :image do |x|
        if x.image.attached?
          image_tag x.image
        end
      end
    end
  end
  
  
end
