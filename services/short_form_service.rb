require 'singleton'
import 'org.semanticweb.owlapi.util.SimpleShortFormProvider'
import 'owl2vcs.render.SimplerRenderer'
import 'owl2vcs.render.FullFormProvider'

class ShortFormService
  include Singleton

  def self.shorten entity
    ShortFormService.instance.short_form_provider.get_short_form entity
  end

  def short_form_provider
    @sfp ||= SimpleShortFormProvider.new
  end

  def full_form_provider
    @ffp ||= FullFormProvider.new
  end



end
