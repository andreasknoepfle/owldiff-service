class OntologyDiff
  SINGLE_CHANGE_TYPES = [:format,:ontology_id]
  SET_CHANGE_TYPES = [:prefix,:import,:annotation,:axiom]
  ENTITIES = [:new,:modified,:removed]

  SINGLE_CHANGE_TYPES.each do |change_type|
    attr_accessor "#{change_type}_change".to_sym
  end

  SET_CHANGE_TYPES.each do |change_type|
    attr_accessor "#{change_type}_changes".to_sym
  end

  ENTITIES.each do |entity_type|
    attr_accessor "#{entity_type}_entities".to_sym
  end

  def initialize binary_identical
    @binary_identical = binary_identical
  end

  def binary_identical?
    @binary_identical
  end

end
