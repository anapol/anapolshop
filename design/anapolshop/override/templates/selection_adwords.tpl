{*?template charset=utf-8?*}
{let selected_id_array=$attribute.content}
{section var=Options loop=$attribute.class_content.options}
{section-exclude match=$selected_id_array|contains( $Options.item.id )|not}
{$Options.item.name|wash( xhtml )}{delimiter}, {/delimiter}{/section}
{/let}
