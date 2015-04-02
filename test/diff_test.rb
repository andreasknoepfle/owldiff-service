require 'test/test_helper'

class DiffTest < Minitest::Test
  include Rack::Test::Methods



  def test_ontology_diff
    diff = OntologyDiffService.new("samples/api4kb1.rdf", "samples/pizzas.owl").diff
    assert !diff.binary_identical?
    assert diff.respond_to?(:to_json)
  end


  def test_format_change
    diff = get_diff(:format_change)
    assert diff.format_change
    assert_equal "OWL/XML", diff.format_change.data
    OntologyDiff::SET_CHANGE_TYPES.each do |type|
      assert_empty diff.send(type)
    end
  end

  def test_ontology_id_change
    diff = get_diff(:ontology_id_change)
    assert diff.ontology_id_change
    assert_equal "<http://www.semanticweb.org/test2>", diff.ontology_id_change.data[:ontology_iri]
  end

  def test_prefix_changes
    diff = get_diff(:prefix_changes)
    assert diff.prefix_changes
    assert_equal 4, diff.prefix_changes.size # 4 instances
    assert_equal OntologyChange::ACTIONS.sort, diff.prefix_changes.map(&:action).sort # all change type detected once
    diff.prefix_changes.each do |change|
      assert_equal :prefix, change.type # only prefix changes
      assert change.data
      assert change.data.size >= 2 # change data present
    end
  end

  def test_import_changes
    diff = get_diff(:import_changes)
    assert diff.import_changes
    assert_equal 2, diff.import_changes.size # 2 instances
    assert_equal [:added,:removed].sort, diff.import_changes.map(&:action).sort # all change type detected once
    diff.import_changes.each do |change|
      assert_equal :import, change.type # only prefix changes
      assert change.data
      assert change.data.is_a? String
    end
  end

  def test_annotation_changes
    diff = get_diff(:annotation_changes)
    assert diff.annotation_changes
    assert_equal 2, diff.annotation_changes.size # 2 instances
    assert_equal [:added,:removed].sort, diff.annotation_changes.map(&:action).sort # all change type detected once
    diff.annotation_changes.each do |change|
      assert_equal :annotation, change.type # only prefix changes
      assert change.data
      assert_equal [:short,:full], change.data.keys
    end
  end

  def test_axiom_changes
    diff = get_diff(:axiom_changes)
    assert diff.axiom_changes
    assert_equal 2, diff.axiom_changes.size # 2 instances
    assert_equal [:added,:removed].sort, diff.axiom_changes.map(&:action).sort # all change type detected once
    diff.axiom_changes.each do |change|
      assert_equal :axiom, change.type # only prefix changes
      assert change.data
      assert_equal [:short,:full], change.data.keys
    end
  end

  private

  def get_diff type
    OntologyDiffService.new("test/fixtures/#{type}_a.owl", "test/fixtures/#{type}_b.owl").diff
  end


end
