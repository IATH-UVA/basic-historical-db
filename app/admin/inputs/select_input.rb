class Formtastic::Inputs::SelectInput
  def input_html_options
    super.merge({class: 'searchable-select-input', collection: []}) do |k, ov, nv|
      if k == :class
        if ov.include?('searchable-select-input') || ov.include?('custom-placeholder')
          ov
        else
          "#{ov} searchable-select-input"
        end
      elsif k == :collection
        if @options[:ajax].present? && ov.empty?
          @object[method]
        else
          ov
        end 
      else
        ov
      end
    end
    
  end
end