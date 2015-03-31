class OntologyChange
  attr_accessor :value, :type, :action, :data
  ACTIONS = [:added,:removed,:renamed,:modified]

  def initialize value, type, action, data
    @value, @type, @action, @data =  value, type, action, data
  end

  def to_json
    {
      'value' => value,
      'type' => type.to_s,
      'action' => action.to_s,
      'data' => data
    }
  end

end
