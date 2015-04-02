class OntologyDiff
  SINGLE_CHANGE_TYPES = [:format,:ontology_id].map{ |type| "#{type}_change".to_sym }
  SET_CHANGE_TYPES = [:prefix,:import,:annotation,:axiom].map{ |type| "#{type}_changes".to_sym }
  ENTITIES = [:new,:modified,:removed].map{ |type| "#{type}_entities".to_sym }

  ALL_TYPES = SINGLE_CHANGE_TYPES + SET_CHANGE_TYPES + ENTITIES

  ALL_TYPES.each do |type|
    attr_accessor type
  end

  def initialize binary_identical
    @binary_identical = binary_identical
  end

  def binary_identical?
    @binary_identical
  end

  def to_json(*opts)
    diff = { binary_identical: @binary_identical }
    ALL_TYPES.each do |type|
      diff[type] = self.send(type)
    end
    diff.to_json(*opts)
  end

end
