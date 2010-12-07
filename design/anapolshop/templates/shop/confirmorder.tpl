{*?template charset=utf-8?*}
<form method="post" action={"/shop/confirmorder/"|ezurl}>
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-confirmorder">

<ul>
    <li>1. <a href={"/shop/basket"|ezurl()}>Nákupní košík</a></li>
    <li>2. <a href={"/anapolshop/userregister"|ezurl()}>Zákazník</a></li>
    <li>3. Doprava a typ platby
    <li class="selected">4. Potvrzení objednávky</li>
</ul>
<div class="buttonblock">
<input class="button" type="submit" name="CancelButton" value="Storno" /> &nbsp;
<input class="button" type="submit" name="ConfirmOrderButton" value="Potvrdit objednávku" /> &nbsp;
</div>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-confirmorder">

{*<form method="post" action={"/shop/confirmorder/"|ezurl}>*}

<div class="attribute-header">
    <h1 class="long">Závěrečné potvrzení objednávky</h1>
</div>
<p>Zkontrolujte prosím zadané údaje a údaje o objednaném zboží. Pokud vše souhlasí, potvrďte svou objednávku pomocí tlačítka <input class="button" type="submit" name="ConfirmOrderButton" value="Potvrdit objednávku" />. Pokud byste chtěli provést jakékoliv úpravy v údajích objednávky, můžete jít zpět do <a href={"/shop/basket"|ezurl()}>košíku</a> a provést objednávku znovu s opravenými údaji (již vyplněné údaje zůstanou zachovány).</p>

{shop_account_view_gui view=html order=$order}

{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
     $locale = false()
     $symbol = false()}

{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}


<h3>{"Product items"|i18n("design/ezwebin/shop/confirmorder")}</h3>
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>
    {"Count"|i18n("design/ezwebin/shop/confirmorder")}
    </th>
{*    <th>
    {"VAT"|i18n("design/ezwebin/shop/confirmorder")}
    </th>
*}    <th>
    Jednotková cena
    </th>
    <th>
    {"Discount"|i18n("design/ezwebin/shop/confirmorder")}
    </th>
{*    <th>
    {"Total price ex. VAT"|i18n("design/ezwebin/shop/confirmorder")}
    </th>
*}    <th>
    {"Total price inc. VAT"|i18n("design/ezwebin/shop/confirmorder")}
    </th>
</tr>
{section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
<tr class="bglight">
    <td colspan="{*6*}4">    <input type="hidden" name="ProductItemIDList[]" value="{$ProductItem:item.id}" />
    <a href={concat("/content/view/full/",$ProductItem:item.node_id,"/")|ezurl}>{$ProductItem:item.object_name}</a></td>
</tr>
<tr class="bgdark">
    <td>
    {$ProductItem:item.item_count}
    </td>
{*    <td>
    {$ProductItem:item.vat_value} %
    </td>
*}    <td>
    {$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    {$ProductItem:item.discount_percent}%
    </td>
{*    <td>
    {$ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
*}    <td>
    {$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>
{section show=$ProductItem:item.item_object.option_list}
<tr>
  <td colspan="{*6*}4" style="padding: 0;">
     <table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td colspan="3">
{"Selected options"|i18n("design/ezwebin/shop/confirmorder")}
</td>
</tr>
     {section name=Options loop=$ProductItem:item.item_object.option_list}
      <tr>
        <td width="33%">{$ProductItem:Options:item.name}</td>
        <td width="33%">{$ProductItem:Options:item.value}</td>
        <td width="33%">{$ProductItem:Options:item.price|l10n( 'currency', $locale, $symbol )}</td>
      </tr>
    {/section}
     </table>
   </td>
</tr>
{/section}

{/section}
</table>



<h3>{"Order summary"|i18n("design/ezwebin/shop/confirmorder")}:</h3>
<table class="list" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>Shrnutí</th>
{*    <th>Celkem bez DPH</th>
*}    <th>Celkem s DPH</th>
</tr>
<tr class="bglight">
    <td>
    {"Subtotal of items"|i18n("design/ezwebin/shop/confirmorder")}:
    </td>
{*    <td>
    {$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
*}    <td>
    {$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>

{section name=OrderItem loop=$order.order_items show=$order.order_items sequence=array(bgdark,bglight)}
<tr class="{$OrderItem:sequence}">
    <td>
    {$OrderItem:item.description}:
    </td>
{*    <td>
    {$OrderItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
*}    <td>
    {$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>
{/section}
<tr class="bgdark">
    <td>
    Objednávka celkem:
    </td>
{*    <td>
    {$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
*}    <td>
    {$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>
</table>

<div class="buttonblock">
<input class="button" type="submit" name="CancelButton" value="{'Cancel'|i18n('design/ezwebin/shop/confirmorder')}" /> &nbsp;
<input class="button" type="submit" name="ConfirmOrderButton" value="Potvrdit objednávku" /> &nbsp;
</div>

</form>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
