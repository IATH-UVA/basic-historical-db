ActiveAdmin.register Biography do
  menu priority: 2

  permit_params :biography_type_id, :title, :subtitle, :text, :info, :date_yyyy, :date_mm, :date_dd, :display_order, :image, :pdf

  controller do
    def scoped_collection
      end_of_association_chain.includes([:biography_type]).references([:biography_type])
    end
  end

  preserve_default_filters!
  remove_filter :image_attachment
  remove_filter :image_blob
  remove_filter :pdf_attachment
  remove_filter :pdf_blob

  index do
    selectable_column
    column :id do |x|
      div x.id
      div link_to 'view', admin_biography_path(x)
      div link_to 'edit', edit_admin_biography_path(x)
    end
    column :biography_type, sortable: 'biography_types.name'
    column :title
    column :subtitle
    column :text do |x|
      x.text.try(&:html_safe)
    end
    column :info
    column :date_yyyy
    column :date_mm
    column :date_dd
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
      f.input :biography_type
      f.input :title
      f.input :subtitle
      f.input :text, as: :quill_editor
      f.input :info
      f.input :date_yyyy
      f.input :date_mm
      f.input :date_dd
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
        else
          row field
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
