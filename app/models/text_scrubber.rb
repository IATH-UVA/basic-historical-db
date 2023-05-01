class TextScrubber < Rails::Html::PermitScrubber
  def initialize
    super
    self.tags = %w(div br p figure span h1 h2 h3 h4 img figcaption comment blockquote strong em a ul li ol del a)
    self.attributes = %w( style data-trix-attachment data-trix-content-type data-trix-attributes src width height class href)
  end

  def skip_node?(node)
    node.text?
  end
end

# use in activeadmin like this:

# row :text do |x|
#   span sanitize x.text, scrubber: TextScrubber.new
# end

# f.input :text, as: :action_text