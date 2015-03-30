require 'lib/owl2vcs.jar'
import 'org.semanticweb.owlapi.io.FileDocumentSource'
import 'owl2vcs.tools.Diff'
import 'java.util.HashSet'
import 'java.util.HashMap'
import 'owl2vcs.analysis.EntityCollector'
import 'owl2vcs.analysis.EntityClassifier'
import 'owl2vcs.changeset.FullChangeSet'
import 'owl2vcs.utils.OntologyUtils'
import 'owl2vcs.analysis.PrefixExtractor'
require 'pry'

class OntologyDiff

  attr_reader :cs, :entities, :new_entities, :modified_entities, :removed_entities

  def initialize owl1_path, owl2_path
    @source1 = java_load_file owl1_path
    @source2 = java_load_file owl2_path
    load_ontologies unless binary_identical?
    diff
  end

  def binary_identical?
    @binary_identical ||= Diff.binary_compare_sources @source1, @source2
  end

  def format_changes
    @format1 = @owl1.owl_ontology_manager.get_ontology_format @owl1
    @format2 = @owl2.owl_ontology_manager.get_ontology_format @owl2
    if @format1.prefix_owl_ontology_format? && @format2.prefix_owl_ontology_format?
      prefixes = extract_prefixes @entities, @format1, @format2
    end
    prefixes.to_hash
  end

  def changed_axioms
    @cs.axiom_changes.map do |change|
      ChangeMappingService.map change
    end
  end

  private

  def java_load_file path
    FileDocumentSource.new(java.io.File.new(path))
  end

  def load_ontologies
    @owl1 = OntologyUtils.loadOntology(@source1);
    @owl2 = OntologyUtils.loadOntology(@source2);
  end

  def diff
    return nil if binary_identical?

    @cs = FullChangeSet.new @owl1, @owl2

    @entities = HashSet.new
    @new_entities = HashSet.new
    @removed_entities = HashSet.new
    @modified_entities = HashSet.new
    @cs.accept(EntityCollector.new(@entities,HashSet.new))

    EntityClassifier.new(@owl1, @owl2, @entities, @new_entities,
           @removed_entities, @modified_entities);

  end



  def extract_prefixes entities, format1, format2
    all_prefixes = HashMap.new;
    all_prefixes.put_all(format1.asPrefixOWLOntologyFormat
                .getPrefixName2PrefixMap)
    all_prefixes.put_all(format2.asPrefixOWLOntologyFormat
                .getPrefixName2PrefixMap)
    PrefixExtractor.new(entities, all_prefixes).getPrefixName2PrefixMap
  end





end
