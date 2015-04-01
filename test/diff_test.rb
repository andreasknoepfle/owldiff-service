require 'test/test_helper'

class DiffTest < Minitest::Test
  include Rack::Test::Methods

  def test_ontology_diff
    diff = OntologyDiffService.new("samples/api4kb1.rdf", "samples/pizzas.owl").diff
    assert !diff.binary_identical?
  end

end
