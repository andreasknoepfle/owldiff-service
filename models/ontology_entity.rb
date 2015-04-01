class OntologyEntity
  attr_accessor :short, :full
  def initialize short, full
    @short, @full = short, full
  end

  def to_json
    {
      short: @short,
      full: @full
    }
  end

end
