
ACTION_TO_COLOR = {
  added: "green",
  removed: "red",
  renamed: "blue",
  modified: "purple"
}

LABEL_TEXT_MAPPING = {
  format: "Ontology Format Changes",
  prefix: "Prefix Changes",
  ontology_id: "Ontology ID Changes",
  import: "Import Changes",
  annotation: "Annotation Data Changes",
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
    if data.is_a? String
      return h(data)
    end
    output = "<dl>"
    data.each do |k,v|
      output += "<dt>#{h(k.to_s)}</dt>"
      output += "<dd style='word-wrap: break-word;'>#{h(v.to_s)}</dd>"
    end
    output += "</dl>"
    output
  end

end
