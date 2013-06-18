{*?template charset=utf-8?*}
{def $isbn=''}
{set-block scope=root variable=subject}Objednávka example.com číslo {$order.order_nr}{/set-block}
Dobrý den,

toto je automaticky generované potvrzení uložení Vaší objednávky v internetovém obchodě example.com.

Objednávka číslo {$order.order_nr}

{shop_account_view_gui view=ascii order=$order}
{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
         $locale = false()
         $symbol = false()}
{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}
{def $predem=false()}
{"Product items"|i18n("design/standard/shop")}:

{foreach $order.product_items as $item}
{set $isbn=''}
{if $item.item_object.contentobject.contentclass_id|eq(36)}
{if $item.item_object.contentobject.data_map.isbn.has_content}
{set $isbn=$item.item_object.contentobject.data_map.isbn.content.value}
{/if}
{/if}
{if $item.item_count|gt(1)}{$item.item_count} x {/if}{$item.object_name} {if $isbn}(ISBN: {$isbn}){/if}: {$item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}

{if $item.item_object.option_list|count()|gt(0)}
{foreach $item.item_object.option_list as $anaoption}
     - volba: {$anaoption.name}: {$anaoption.value}

{/foreach}
{/if}
{/foreach}

{"Subtotal Inc. VAT"|i18n("design/base/shop")}: {$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}

{foreach $order.order_items as $orderItem}
{$orderItem.description}: {$orderItem.price_inc_vat|l10n( 'currency', $locale, $symbol )}
{if $orderItem.description|contains('edem')}
{set $predem=true()}
{/if}
{/foreach}

-------------------------------------------
Celkem včetně DPH: {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}

{*
{"Order summary"|i18n("design/base/shop")}:

{"Subtotal of items Ex VAT"|i18n("design/base/shop")}: {$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}

{foreach $order.order_info.additional_info as $order_item_type => $additional_info}
{if $order_item_type|eq('ezcustomshipping')}
{"Shipping total Ex VAT"|i18n("design/base/shop")}: {$additional_info.total.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
{else}
{"Item total Ex. VAT"|i18n("design/base/shop")}: {$additional_info.total.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
{/if}

{/foreach}


{if $order.order_info.additional_info|count|gt(0)}
{foreach $order.order_info.price_info.items as $vat_value => $order_info
           sequence array(bglight, bgdark) as $sequence}
{if $order_info.total_price_vat|gt(0)}
{"Total VAT"|i18n("design/base/shop")} ({$vat_value}%) {$order_info.total_price_vat|l10n( 'currency', $locale, $symbol )}

{/if}
{/foreach}
{/if}
{"Order total"|i18n("design/base/shop")}: {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
{undef $currency $locale $symbol}
*}

{if $predem}
Platba: 
 Zvolili jste platbu předem. Zaplaťte prosím pomocí níže uvedených údajů:
 
 Číslo účtu: 000000000/5500 Raiffeisenbank
 částka: {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
 Variabilní symbol: {$order.order_nr}
 Konstantní symbol: 0308
 Fakturu zašleme společně s objednaným zbožím, pokud potřebujete fakturu dříve, napište nám prosím.
{/if}


Tip: pokud jste zaregistrováni v našem obchodě, můžete stav vyřízení Vaší objednávky sledovat po přihlášení ve Vašem profilu.

Informační mail o novinkách si můžete objednat na
http://example.com/cze/o_nas/objednani_odberu_informacniho_mailu


Děkujeme za Váš nákup.

example.com
