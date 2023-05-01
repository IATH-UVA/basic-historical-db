class ActionTextInput < Formtastic::Inputs::StringInput

  def to_html
    input_wrapping do
      editor_tag_params = {
              input: input_html_options[:id],
              class: 'trix-content',
              data: {
                direct_upload_url: Rails.application.routes.url_helpers.rails_direct_uploads_path,
                blob_url_template: Rails.application.routes.url_helpers.rails_service_blob_path(":signed_id", ":filename")
              }
      }
      editor_tag = template.content_tag('trix-editor', '', editor_tag_params)
      hidden_field = builder.hidden_field(method, input_html_options)
      label_html + hidden_field + editor_tag
    end
  end
end