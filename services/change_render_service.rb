import 'owl2vcs.render.FunctionalChangeRenderer'
require 'singleton'

class ChangeRenderService
  include Singleton

  def self.render change
    ChangeRenderService.instance.change_renderer.render change
  end

  def self.render_object_short object
    ChangeRenderService.instance.short_form_renderer.render object
  end

  def self.render_object_full object
    ChangeRenderService.instance.full_form_renderer.render object
  end

  def change_renderer
    @fcr ||= FunctionalChangeRenderer.new ShortFormService.instance.short_form_provider, nil
  end

  def full_form_renderer
    return @ffr if @ffr
    @ffr = SimplerRenderer.new
    @ffr.set_short_form_provider(ShortFormService.instance.full_form_provider)
    @ffr
  end

  def short_form_renderer
    return @sfr if @sfr
    @sfr = SimplerRenderer.new
    @sfr.set_short_form_provider(ShortFormService.instance.short_form_provider)
    @sfr
  end



end
