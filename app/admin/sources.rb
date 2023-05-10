ActiveAdmin.register Source do
  menu priority: 4

  permit_params :source_type_id, :title, :subtitle, :text, :info, :date_yyyy, :date_mm, :date_dd, :date_display, :display_order, :link, :image, :pdf

  controller do
    def scoped_collection
      end_of_association_chain.includes([:source_type]).references([:source_type])
    end
  end

  preserve_default_filters!
  remove_filter :image_attachment
  remove_filter :image_blob
  remove_filter :pdf_attachment
  remove_filter :pdf_blob
  remove_filter :events

  index do
    selectable_column
    column :id do |x|
      div x.id
      div link_to 'view', admin_source_path(x)
      div link_to 'edit', edit_admin_source_path(x)
    end
    column :source_type, sortable: 'source_types.name'
    column :title
    column :subtitle
    column :text do |x|
      x.text.try(&:html_safe)
    end
    column :info
    column :date_yyyy
    column :date_mm
    column :date_dd
    column :date_display
    column :link do |x|
      if x.link.present?
        link_to x.link, x.link, target: "_blank"
      end
    end
    column :events
    column :image do |x|
      if x.image.attached?
        image_tag x.image
      end
    end
    column :pdf do |x|
      if x.pdf.attached?
        link_to x.pdf.filename, rails_blob_path(x.pdf, disposition: "attachment")
      end
    end
    column :display_order
    column :created_at
    column :updated_at
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs do
      f.input :source_type
      f.input :title
      f.input :subtitle
      f.input :text, as: :quill_editor
      f.input :info
      f.input :date_yyyy
      f.input :date_mm
      f.input :date_dd
      f.input :date_display
      f.input :link
      f.input :image, as: :file
      f.input :pdf, as: :file
      f.input :display_order
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
      row :events do |x|
        ul do
          x.events.each do |event|
            li link_to(event.title.present? ? event.title : event.id, admin_event_path(event))
          end
        end
      end
      row :image do |x|
        if x.image.attached?
          image_tag x.image
        end
      end
      row :pdf do |x|
        if x.pdf.attached?
          link_to x.pdf.filename, rails_blob_path(x.pdf, disposition: "attachment")
        end
      end
    end
  end
  
  
end
