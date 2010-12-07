{*?template charset=utf-8?*}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-customerorderview">
    <div class="attribute-header">
        <h1 class="long">Seznam objednávek zákazníka</h1>
    </div>

{*<p>Informace zákazníka z poslední objednávky</p>
   
{shop_account_view_gui view=html order=$order_list[count($order_list)|sub(1)]}


*}
<div class="attribute-header">
    <h1>Seznam aktuálních objednávek</h1>
</div>

{def $currency = false()
     $locale = false()
     $symbol = false()
     $product_info_count = false()}

{if $order_list}
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>
    Číslo objednávky
    </th>
    <th>
    Datum
    </th>
{*    <th>
    {"Total ex. VAT"|i18n("design/ezwebin/shop/customerorderview")}
    </th>
*}    <th>
    Celkem s DPH
    </th>
    <th>
    </th>
</tr>
{foreach $order_list as $order sequence array(bglight,bgdark) as $seq reverse}
{set currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) ) }
{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{else}
    {set locale = false()
         symbol = false()}
{/if}

<tr class="{$seq}">
    <td>
    {$order.order_nr}
    </td>
    <td>
    {$order.created|l10n(shortdatetime)}
    </td>
{*    <td>
    {$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
*}    <td>
    {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    <a href={concat("/anapolshop/orderview/",$order.id,"/")|ezurl}>zobrazit</a>
    </td>
</tr>
{/foreach}
</table>
{else}
Bez aktuálních objednávek.
{/if}

{set $currency = false()
     $locale = false()
     $symbol = false()
     $product_info_count = false()}
<div class="attribute-header">
    <h1>Seznam archivovaných objednávek</h1>
</div>
{if $archived_order_list}
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>
    Číslo objednávky
    </th>
    <th>
    Datum
    </th>
{*    <th>
    {"Total ex. VAT"|i18n("design/ezwebin/shop/customerorderview")}
    </th>
*}    <th>
    Celkem s DPH
    </th>
    <th>
    </th>
</tr>
{foreach $archived_order_list as $order sequence array(bglight,bgdark) as $seq reverse}
{set currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) ) }
{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{else}
    {set locale = false()
         symbol = false()}
{/if}

<tr class="{$seq}">
    <td>
    {$order.order_nr}
    </td>
    <td>
    {$order.created|l10n(shortdatetime)}
    </td>
{*    <td>
    {$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
*}    <td>
    {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    <a href={concat("/anapolshop/orderview/",$order.id,"/")|ezurl}>zobrazit</a>
    </td>
</tr>
{/foreach}
</table>
{else}
Bez archivovaných objednávek.
{/if}

{*
<div class="attribute-header">
  <h1>{"Purchase list"|i18n("design/ezwebin/shop/customerorderview")}</h1>
</div>

{section show=$product_list}
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>
    {"Product"|i18n("design/ezwebin/shop/customerorderview")}
    </th>
    <th>
    {"Amount"|i18n("design/ezwebin/shop/customerorderview")}
    </th>
    <th>
    {"Total ex. VAT"|i18n("design/ezwebin/shop/customerorderview")}
    </th>
    <th>
    {"Total inc. VAT"|i18n("design/ezwebin/shop/customerorderview")}
    </th>
</tr>

{def $quantity_text = ''
     $total_ex_vat_text = ''
     $total_inc_vat_text = ''
     $br_tag = ''}

{section var="Product" loop=$product_list sequence=array(bglight,bgdark)}

    {set quantity_text = ''
         total_ex_vat_text = ''
         total_inc_vat_text = ''
         br_tag = ''}

    {foreach $Product.product_info as $currency_code => $info}
        {if $currency_code}
            {set currency = fetch( 'shop', 'currency', hash( 'code', $currency_code ) ) }
        {else}
            {set currency = false()}
        {/if}
        {if $currency}
            {set locale = $currency.locale
                 symbol = $currency.symbol}
        {else}
            {set locale = false()
                 symbol = false()}
        {/if}

        {set quantity_text = concat( $quantity_text, $br_tag, $info.sum_count) }
        {set total_ex_vat_text = concat($total_ex_vat_text, $br_tag, $info.sum_ex_vat|l10n( 'currency', $locale, $symbol )) }
        {set total_inc_vat_text = concat($total_inc_vat_text, $br_tag, $info.sum_inc_vat|l10n( 'currency', $locale, $symbol )) }

        {if $br_tag|not()}
            {set br_tag = '<br />'}
        {/if}
    {/foreach}

    <tr class="{$Product.sequence}">
        <td>{content_view_gui view=text_linked content_object=$Product.product}</td>
        <td align="right">{$quantity_text}</td>
        <td align="right">{$total_ex_vat_text}</td>
        <td align="right">{$total_inc_vat_text}</td>
    </tr>

{/section}

</table>
{/section}
*}
{undef}



</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
