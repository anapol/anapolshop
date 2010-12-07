{*?template charset=utf-8?*}
{def $shopitems=fetch('content', 'list', hash('parent_node_id', 2, 'depth', 5, 'class_filter_type', 'include',
'class_filter_array', array('kniha'), 'main_node_only', true()))}
{cache-block }
<?xml version="1.0" encoding="utf-8"?>
<SHOP>
{foreach $shopitems as $shopitem}
{*if $shopitem.can_read*}
<SHOPITEM>
<PRODUCT>{$shopitem.name|shorten(60)|xmlwash}</PRODUCT>
<DESCRIPTION>{$shopitem.data_map.short_description.content.output.output_text|striptags|trim|shorten(500)|xmlwash}</DESCRIPTION>
<URL>http://www.noty-video.cz{$shopitem.url_alias|ezurl('no')}</URL>
{if $shopitem.data_map.image.content.is_valid}
<IMGURL>http://www.noty-video.cz{$shopitem.data_map.image.content['original'].url|ezroot('no')}</IMGURL>
{/if}
<PRICE_VAT>{$shopitem.data_map.price.content.inc_vat_price}</PRICE_VAT>
<AVAILABILITY>{if $shopitem.data_map.at_stock.content}0{else}504{/if}</AVAILABILITY>
</SHOPITEM>
{*/if*}
{/foreach}
</SHOP>
{/cache-block}