
ACTION_TO_COLOR = {
  added: "green",
  removed: "red",
  renamed: "blue",
  modified: "purple"
}

LABEL_TEXT_MAPPING = {
  ontology_format: "Ontology Format Changes",
  prefix: "Prefix Changes",
  ontology_id: "Ontology ID Changes",
  import: "Import Changes",
  anotation_data: "Annotation Data Changes",
  axiom: "Axiom Changes"
}

helpers do
  def style_helper(action)
    ACTION_TO_COLOR[action]
  end

  def label_text_change_type type
    LABEL_TEXT_MAPPING[type]
  end

  def h(text)
    Rack::Utils.escape_html(text)
  end

  def format_popover(data)
    output = "<dl>"
    data.each do |k,v|
      output += "<dt>#{Rack::Utils.escape_html(k.to_s)}</dt>"
      output += "<dd style='word-wrap: break-word;'>#{Rack::Utils.escape_html(v.to_s)}</dd>"
    end
    output += "</dl>"
    output
  end

end
