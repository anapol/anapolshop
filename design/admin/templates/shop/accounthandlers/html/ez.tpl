{*?template charset=utf-8?*}

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
<td valign="top">
<p>
<b>{"Customer"|i18n("design/anapolshop/ezhtmlaccounthandler")}</b>
</p>
<p>
{'Name'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaTitul} {$order.account_information.first_name} {$order.account_information.last_name}<br />
{'Email'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.email}<br />
</p>

</td>
<td valign="top">

<p>
<b>{'Shipping address'|i18n('design/anapolshop/ezhtmlaccounthandler')}</b>
</p>
<p>
{'Customer name'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaTitul} {$order.account_information.first_name} {$order.account_information.last_name}<br />
{if $order.account_information.street1}{'Company'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.street1}<br />{/if}
{'Street'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.street2}<br />
{'City'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.place}<br />
{'Post code'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.zip}<br />
</p>
</td>
</td>
<td valign="top">

<p>
<b>{'Billing address'|i18n('design/anapolshop/ezhtmlaccounthandler')}</b>
</p>
<p>
{if $order.account_information.anaDodFirma|or($order.account_information.anaDodJmeno)|or($order.account_information.anaDodPrijmeni)|or($order.account_information.anaDodUlice)|or($order.account_information.anaDodMesto)|or($order.account_information.anaDodPSC)|or($order.account_information.anaICO)|or($order.account_information.anaDIC)}

 {if $order.account_information.anaDodFirma}
  {'Company'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaDodFirma}<br/>
 {/if}

 {if $order.account_information.anaDodJmeno}
  {'Name'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaDodJmeno} {$order.account_information.anaDodPrijmeni}<br />
 {/if}

 {if $order.account_information.anaICO}{'Reg id'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaICO}<br />{/if}

 {if $order.account_information.anaDIC}{'VAT id'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaDIC}<br />{/if}

 {if $order.account_information.anaDodUlice}
  {'Street'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaDodUlice}<br />
 {/if}

 {if $order.account_information.anaDodMesto}
  {'City'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaDodMesto}<br />
 {/if}

 {if $order.account_information.anaDodPSC}
  {'Post code'|i18n('design/anapolshop/ezhtmlaccounthandler')}: {$order.account_information.anaDodPSC}<br />
 {/if}

{else}
 {'Same as shipping address.'|i18n('design/anapolshop/ezhtmlaccounthandler')}
{/if}
</p>
</td>

<td valign="top">

<p>
<b>{'Your note'|i18n('design/anapolshop/ezhtmlaccounthandler')}</b>
</p>
<p>
{if $order.account_information.comment}
{$order.account_information.comment}
{else}
 {'Without note.'|i18n('design/anapolshop/ezhtmlaccounthandler')}
{/if}
</p>
</td>


</tr>
</table>
