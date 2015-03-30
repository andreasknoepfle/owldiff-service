import 'org.semanticweb.owlapi.change.AddAxiomData'
import 'org.semanticweb.owlapi.change.AddImportData'
import 'org.semanticweb.owlapi.change.AddOntologyAnnotationData'
import 'org.semanticweb.owlapi.change.OWLOntologyChangeData'
import 'org.semanticweb.owlapi.change.RemoveAxiomData'
import 'org.semanticweb.owlapi.change.RemoveImportData'
import 'org.semanticweb.owlapi.change.RemoveOntologyAnnotationData'
import 'org.semanticweb.owlapi.change.SetOntologyIDData'
import 'owl2vcs.changes.AddPrefixData'
import 'owl2vcs.changes.ModifyPrefixData'
import 'owl2vcs.changes.RemovePrefixData'
import 'owl2vcs.changes.RenamePrefixData'
import 'owl2vcs.changes.SetOntologyFormatData'


class ChangeMappingService

  def self.map change

    if change.is_a?(SetOntologyFormatData)
      map_change(change,:format, :modified, change.get_new_format.to_string)
    elsif change.is_a?(AddPrefixData)
      map_change(change,:prefix, :added, {name: change.get_prefix_name, prefix: change.get_prefix})
    elsif change.is_a?(RemovePrefixData)
      map_change(change,:prefix, :removed, {name: change.get_prefix_name, prefix: change.get_prefix})
    elsif change.is_a?(ModifyPrefixData)
      map_change(change,:prefix, :modified, {name: change.get_prefix_name,  prefix: change.get_prefix, old_prefix: change.get_old_prefix})
    elsif change.is_a?(RenamePrefixData)
      map_change(change,:prefix, :renamed, {name: change.get_prefix_name, prefix: change.get_prefix, old_name: change.get_old_prefix_name})
    elsif change.is_a?(SetOntologyIDData)
      map_change(change,:ontology_id, :modified, ontology_id_data(change))
    elsif change.is_a?(AddImportData)
      map_change(change,:import, :added, change.get_declaration.get_iri.to_string)
    elsif change.is_a?(RemoveImportData)
      map_change(change,:import, :removed, change.get_declaration.get_iri.to_string)
    elsif change.is_a?(AddOntologyAnnotationData)
      map_change(change,:annotation, :added, object_data(change.get_annotation))
    elsif change.is_a?(RemoveOntologyAnnotationData)
      map_change(change,:annotation, :removed, object_data(change.get_annotation))
    elsif change.is_a?(AddAxiomData)
      map_change(change,:axiom, :added, object_data(change.get_axiom))
    elsif change.is_a?(RemoveAxiomData)
      map_change(change,:axiom, :removed, object_data(change.get_axiom))
    else
      map_change(change,:unknown, :unknown, change.getClass().getName())
    end
  end

  private

  def self.map_change change, type, action, data
    OntologyChange.new ChangeRenderService.render(change), type, action, data
  end

  def self.ontology_id_data change
    new_id = change.get_new_id
    anonymous = new_id.is_anonymous
    if anonymous
      return "anonymous"
    else
      version = new_id.get_version_iri
      version = version.to_quoted_string if version
      return {ontology_iri: new_id.get_ontology_iri.to_quoted_string , version_iri: version }
    end
  end

  def self.object_data change
    {
      short: ChangeRenderService.render_object_short(change),
      full: ChangeRenderService.render_object_full(change)
    }
  end
end
