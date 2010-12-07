{*?template charset=utf-8?*}
{*$anaTitul = $anaICO = $anaDIC = $anaDodJmeno = $anaDodPrijmeni = $anaDodFirma = $anaDodUlice = $anaDodMesto = $anaDodPSC = '';*}

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
<td valign="top">
<p>
<b>{"Customer"|i18n("design/standard/shop")}</b>
</p>
<p>
{'Name'|i18n('design/standard/shop')}: {$order.account_information.anaTitul} {$order.account_information.first_name} {$order.account_information.last_name}<br />
{'Email'|i18n('design/standard/shop')}: {$order.account_information.email}<br />
</p>

</td>
<td valign="top">

<p>
<b>Dodací adresa</b>
</p>
<p>
Jméno: {$order.account_information.anaTitul} {$order.account_information.first_name} {$order.account_information.last_name}<br />
{if $order.account_information.street1}Firma: {$order.account_information.street1}<br />{/if}
Ulice: {$order.account_information.street2}<br />
Obec, město: {$order.account_information.place}<br />
PSČ: {$order.account_information.zip}<br />
</p>
</td>
</td>
<td valign="top">

<p>
<b>Fakturační adresa</b>
</p>
<p>
{if $order.account_information.anaDodFirma|or($order.account_information.anaDodJmeno)|or($order.account_information.anaDodPrijmeni)|or($order.account_information.anaDodUlice)|or($order.account_information.anaDodMesto)|or($order.account_information.anaDodPSC)|or($order.account_information.anaICO)|or($order.account_information.anaDIC)}

 {if $order.account_information.anaDodFirma}
  Firma: {$order.account_information.anaDodFirma}<br/>
 {/if}

 {if $order.account_information.anaDodJmeno}
  Jméno: {$order.account_information.anaDodJmeno} {$order.account_information.anaDodPrijmeni}<br />
 {/if}

 {if $order.account_information.anaICO}IČO: {$order.account_information.anaICO}<br />{/if}

 {if $order.account_information.anaDIC}DIČ: {$order.account_information.anaDIC}<br />{/if}

 {if $order.account_information.anaDodUlice}
  Ulice: {$order.account_information.anaDodUlice}<br />
 {/if}

 {if $order.account_information.anaDodMesto}
  Obec, město: {$order.account_information.anaDodMesto}<br />
 {/if}

 {if $order.account_information.anaDodPSC}
  PSČ: {$order.account_information.anaDodPSC}<br />
 {/if}

{else}
 Stejná jako dodací.
{/if}
</p>
</td>

<td valign="top">

<p>
<b>Vaše poznámka</b>
</p>
<p>
{if $order.account_information.comment}
{$order.account_information.comment}
{else}
Bez poznámky.
{/if}
</p>
</td>


</tr>
</table>
