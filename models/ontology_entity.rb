class OntologyEntity
  attr_accessor :short, :full
  def initialize short, full
    @short, @full = short, full
  end

  def to_json(*opts)
    {
      short: @short,
      full: @full
    }.to_json(*opts)
  end

end
