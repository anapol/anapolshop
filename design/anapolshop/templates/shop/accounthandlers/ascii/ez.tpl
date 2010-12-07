{*?template charset=utf-8?*}
{*$anaTitul = $anaICO = $anaDIC = $anaDodJmeno = $anaDodPrijmeni = $anaDodFirma = $anaDodUlice = $anaDodMesto = $anaDodPSC = '';*}
Zákazník:
 Jméno: {$order.account_information.anaTitul} {$order.account_information.first_name} {$order.account_information.last_name}
 E-mail: {$order.account_information.email}

Dodací adresa
 Jméno: {$order.account_information.anaTitul} {$order.account_information.first_name} {$order.account_information.last_name}

{if $order.account_information.street1} Firma: {$order.account_information.street1}

{/if}
 Ulice: {$order.account_information.street2}
 Obec, město: {$order.account_information.place}
 PSČ: {$order.account_information.zip}

Fakturační adresa:

{if $order.account_information.anaDodFirma|or($order.account_information.anaDodJmeno)|or($order.account_information.anaDodPrijmeni)|or($order.account_information.anaDodUlice)|or($order.account_information.anaDodMesto)|or($order.account_information.anaDodPSC)|or($order.account_information.anaICO)|or($order.account_information.anaDIC)}

{if $order.account_information.anaDodFirma}
 Firma: {$order.account_information.anaDodFirma}

{/if}
{if $order.account_information.anaDodJmeno}
 Jméno: {$order.account_information.anaDodJmeno} {$order.account_information.anaDodPrijmeni}

{/if}
{if $order.account_information.anaICO}
 IČO: {$order.account_information.anaICO}

{/if}
{if $order.account_information.anaDIC}
 DIČ: {$order.account_information.anaDIC}

{/if}
{if $order.account_information.anaDodUlice}
 Ulice: {$order.account_information.anaDodUlice}

{/if}
{if $order.account_information.anaDodMesto}
 Obec, město: {$order.account_information.anaDodMesto}

{/if}

{if $order.account_information.anaDodPSC}
 PSČ: {$order.account_information.anaDodPSC}

{/if}
{else}
 Stejná jako dodací.

{/if}


{if $order.account_information.comment}
Vaše poznámka:
 {$order.account_information.comment}
{/if}

