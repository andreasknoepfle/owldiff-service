require 'lib/owl2vcs.jar'
import 'org.semanticweb.owlapi.io.FileDocumentSource'
import 'owl2vcs.tools.Diff'
import 'java.util.HashSet'
import 'owl2vcs.analysis.EntityCollector'
import 'owl2vcs.analysis.EntityClassifier'
import 'owl2vcs.changeset.FullChangeSet'
import 'owl2vcs.utils.OntologyUtils'
require 'pry'

class DiffService

  attr_reader :cs, :entities, :new_entities, :modified_entities, :removed_entities

  def initialize owl1_path, owl2_path
    @source1 = java_load_file owl1_path
    @source2 = java_load_file owl2_path
    load_ontologies unless binary_identical?
  end

  def binary_identical?
    @binary_identical ||= Diff.binary_compare_sources @source1, @source2
  end

  def load_ontologies
    @owl1 = OntologyUtils.load_ontology(@source1);
    @owl2 = OntologyUtils.load_ontology(@source2);
  end

  def changeset
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

  private
    def java_load_file path
      FileDocumentSource.new(java.io.File.new(path))
    end


end
