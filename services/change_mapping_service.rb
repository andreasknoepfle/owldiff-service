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
  
  MAPPINGS = {   SetOntologyFormatData => :map_set_ontology_format,
                 AddPrefixData =>  :map_add_prefix,
                 RemovePrefixData =>  :map_remove_prefix,
                 ModifyPrefixData =>  :map_modify_prefix,
                 RenamePrefixData =>  :map_rename_prefix,
                 SetOntologyIDData =>  :map_set_ontology_id,
                 AddImportData =>  :map_add_import,
                 RemoveImportData =>  :map_remove_import,
                 AddOntologyAnnotationData =>  :map_add_ontology_annotation,
                 RemoveOntologyAnnotationData => :map_remove_ontology_annotation,
                 AddAxiomData =>  :map_add_axiom,
                 RemoveAxiomData => :map_remove_axiom
  }

  def self.map change
    MAPPINGS.each do |k,v|
      return self.send(v,change) if change.is_a? k 
    end
    map_change(change,:unknown, :unknown, change.getClass().getName())
  end

  private
  
  def self.map_set_ontology_format change
    map_change(change,:format, :modified, change.get_new_format.to_string)
  end
  
  def self.map_add_prefix change
     map_change(change,:prefix, :added, {name: change.get_prefix_name, prefix: change.get_prefix})
  end
  
  def self.map_remove_prefix change
    map_change(change,:prefix, :removed, {name: change.get_prefix_name, prefix: change.get_prefix})
  end
  
  def self.map_modify_prefix change
    map_change(change,:prefix, :modified, {name: change.get_prefix_name,  prefix: change.get_prefix, old_prefix: change.get_old_prefix})
  end   
      
  def self.map_rename_prefix change
    map_change(change,:prefix, :renamed, {name: change.get_prefix_name, prefix: change.get_prefix, old_name: change.get_old_prefix_name})
  end
  
  def self.map_set_ontology_id change
    map_change(change,:ontology_id, :modified, ontology_id_data(change))
  end
  
  def self.map_add_import change
      map_change(change,:import, :added, change.get_declaration.get_iri.to_string)
  end
  
  def self.map_remove_import change
    map_change(change,:import, :removed, change.get_declaration.get_iri.to_string)
  end
  
  def self.map_add_ontology_annotation change
    map_change(change,:annotation, :added, object_data(change.get_annotation))
  end
  
  def self.map_remove_ontology_annotation change
    map_change(change,:annotation, :removed, object_data(change.get_annotation))
  end
  
  def self.map_add_axiom change
    map_change(change,:axiom, :added, object_data(change.get_axiom))
  end
  
  def self.map_remove_axiom change
    map_change(change,:axiom, :removed, object_data(change.get_axiom))
  end
  

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
